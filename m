Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281C3C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C2D20838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgBYXEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:04:15 -0500
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:37452 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729090AbgBYXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:04:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 01AFD181D341A;
        Tue, 25 Feb 2020 23:04:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brake21_7beb87a1c190d
X-Filterd-Recvd-Size: 1650
Received: from XPS-9350 (unknown [172.58.27.58])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 23:04:11 +0000 (UTC)
Message-ID: <37831d22bd91f9694f7b35be158969fb997cc544.camel@perches.com>
Subject: Re: [PATCH] tools/perf/util/*.c: Use "%zd" output format for size_t
 type
From:   Joe Perches <joe@perches.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Date:   Tue, 25 Feb 2020 15:02:39 -0800
In-Reply-To: <20200225063901.20165-1-yangx.jy@cn.fujitsu.com>
References: <20200225063901.20165-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 14:39 +0800, Xiao Yang wrote:
> Avoid the following errors when building perf:
> -----------------------------------------------
> util/session.c: In function 'perf_session__process_compressed_event':
> util/session.c:91:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
>   pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
[]
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
[]
> @@ -88,7 +88,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  		session->decomp_last = decomp;
>  	}
>  
> -	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
> +	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);

likely better as %zu, etc...


