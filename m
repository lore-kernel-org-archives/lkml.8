Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF947C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DF520663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgFOKke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:40:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOKke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:40:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD87DABF4;
        Mon, 15 Jun 2020 10:40:36 +0000 (UTC)
Date:   Mon, 15 Jun 2020 12:40:32 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Tobias Klauser <tklauser@distanz.ch>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Free memory in error case in special_get_alts
In-Reply-To: <20200612115628.8992-1-tklauser@distanz.ch>
Message-ID: <alpine.LSU.2.21.2006151238390.5945@pobox.suse.cz>
References: <20200612115628.8992-1-tklauser@distanz.ch>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jun 2020, Tobias Klauser wrote:

> Avoid a memory leak in case get_alt_entry returns an error.

yes, this is not the only one, but I doubt we want to spend time on that. 
The process is about to exit anyway.

Miroslav

> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/objtool/special.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/special.c b/tools/objtool/special.c
> index e74e0189de22..f6f7dee1ba77 100644
> --- a/tools/objtool/special.c
> +++ b/tools/objtool/special.c
> @@ -188,8 +188,10 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
>  			memset(alt, 0, sizeof(*alt));
>  
>  			ret = get_alt_entry(elf, entry, sec, idx, alt);
> -			if (ret)
> +			if (ret) {
> +				free(alt);
>  				return ret;
> +			}
>  
>  			list_add_tail(&alt->list, alts);
>  		}
> -- 
> 2.27.0
> 

