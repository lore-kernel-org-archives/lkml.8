Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58BBC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7682208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBSTw6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:52:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBSTw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:52:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67EC4208C4;
        Wed, 19 Feb 2020 19:52:57 +0000 (UTC)
Date:   Wed, 19 Feb 2020 14:52:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <zhe.he@windriver.com>
Cc:     <acme@redhat.com>, <tstoyanov@vmware.com>,
        <hewenliang4@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools lib traceevent: Take care of return value of
 asprintf
Message-ID: <20200219145256.02a92ad8@gandalf.local.home>
In-Reply-To: <1581686481-180476-1-git-send-email-zhe.he@windriver.com>
References: <1581686481-180476-1-git-send-email-zhe.he@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 21:21:21 +0800
<zhe.he@windriver.com> wrote:

> From: He Zhe <zhe.he@windriver.com>
> 
> According to the API, if memory allocation wasn't possible, or some other
> error occurs, asprintf will return -1, and the contents of strp below are
> undefined.
> 
> int asprintf(char **strp, const char *fmt, ...);
> 
> This patch takes care of return value of asprintf to make it less error
> prone and prevent the following build warning.
> 
> ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2: directly check the return value without saving to a variable
> 
>  tools/lib/traceevent/parse-filter.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
> index 20eed71..6cd0228 100644
> --- a/tools/lib/traceevent/parse-filter.c
> +++ b/tools/lib/traceevent/parse-filter.c
> @@ -274,8 +274,7 @@ find_event(struct tep_handle *tep, struct event_list **events,
>  		sys_name = NULL;
>  	}
>  
> -	ret = asprintf(&reg, "^%s$", event_name);
> -	if (ret < 0)
> +	if (asprintf(&reg, "^%s$", event_name) < 0)

I know Arnaldo said you don't need to save the return value for the
check, but let's just modify the asprintf() that needs checking, and
not remove those that already save it.

Thanks!

-- Steve

