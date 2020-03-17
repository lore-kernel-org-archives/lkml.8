Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D927DC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0B2205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tt+YF24j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgCQIWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:22:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38771 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:22:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so9302125plz.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S2YGO8hzm/1fcL5wpw6053JutNwav0C8AiM1n0QLEJQ=;
        b=tt+YF24jXkH4DM2UPX3by871WLRY4lJS9/PgQ3JcC+pZiDfqTI72Toa0UhnV1blIER
         ferVEZVuDowmSFATTGRgXZzaiabKPqIr8sXX3jEOKI4eODGwy3kPCLqB0RgdmqpNp3ub
         FUF60dlbYzcD3jtnlbyEBnJ0/Yv8FDwqp4Ci9JUMUXKYx0jRMZCPsd0aBuKrFMkhd4pz
         JsifRxQLQ0I/Um+E/9vxEblk74TyqRhKZXdmYqaxXglJlCUZKWPXc38U3jdG5RdRILSS
         mwM+BeUDnJwARYv1wXCrfU92TZIxOo47fEp6t3C+Ol9dHGmu/WmOhy5Qe8LkoGQ+isn+
         zOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S2YGO8hzm/1fcL5wpw6053JutNwav0C8AiM1n0QLEJQ=;
        b=HpbfLZyIy/mVeM/ME2crwOriTd8VdGqDZK5MzEPb12RYB84SrKj4mcoiq8SpPVQzFy
         +nMBN+gEihkhXfAa5pwRRSrRf2gxmZNsrv37fdudNzvXCzGX1TXiM/fdHwiKwzrEBg5r
         ws5whMOd4medw7F68fZvVMPM2qrYvBLlqO1Z8G7r4slo7cVbuUTxmWY2uFhaYpGKZsBq
         exg4R5bB94VHAh8kBIgBPgj2q8HldPmZQy3HFuejlQ018yDhArnrwubTQpAcezJ4zU31
         /sVFVx9czhn0wwUEb7+DLgH6PsCPbdalGVofqflhHwvdbeGyJzKZWe5OF7VwF41hxQp+
         H7jg==
X-Gm-Message-State: ANhLgQ36rqTDGP1xSJeWhB3kJXUQBsMxe94D+eeevnUc6TxUpLzkJddu
        wluqhJULW9mssceZJ1IYaNE=
X-Google-Smtp-Source: ADFU+vvcUoxwSV/QfKtwuyZl9nq8hzXjTUPjOPwh177PntOmiNmWzrBdoV0eRhfNJ/Vn83jYM7xjug==
X-Received: by 2002:a17:902:a9c5:: with SMTP id b5mr3274017plr.126.1584433362206;
        Tue, 17 Mar 2020 01:22:42 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id s25sm2132325pfe.147.2020.03.17.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 01:22:41 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:22:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Shreyas Joshi <shreyas.joshi@biamp.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20200317082239.GA4494@google.com>
References: <20200309052915.858-1-shreyas.joshi@biamp.com>
 <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200316213900.6b1eb594@oasis.local.home>
 <20200317020144.GB219881@google.com>
 <20200317021736.syreot6rs5rtqsh3@shreyas_biamp.biamp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317021736.syreot6rs5rtqsh3@shreyas_biamp.biamp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/16 19:17), Shreyas Joshi wrote:
> 
> Thanks! I thought If we put a warning there then it won’t print anything.
> Please advise. I will send a new patch with the line wrapping to at most 75  once
> I know if I need to change anything more. 
> 

What I'm thinking about is turning "param=\0" into invalid case,
not just for printk(), for in general. Treat it as a NULL value.

Something like this, perhaps?

---
 init/main.c   | 4 ++++
 lib/cmdline.c | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index d46b5673ecb4..46b732cd2615 100644
--- a/init/main.c
+++ b/init/main.c
@@ -673,6 +673,10 @@ static int __init do_early_param(char *param, char *val,
 		    (strcmp(param, "console") == 0 &&
 		     strcmp(p->str, "earlycon") == 0)
 		) {
+			if (!val && strchr(p->str, '=')) {
+				pr_warn("Malformed early option '%s'\n", param);
+				continue;
+			}
 			if (p->setup_func(val) != 0)
 				pr_warn("Malformed early option '%s'\n", param);
 		}
diff --git a/lib/cmdline.c b/lib/cmdline.c
index fbb9981a04a4..33fa0fc505a0 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -222,9 +222,9 @@ char *next_arg(char *args, char **param, char **val)
 	}
 
 	*param = args;
-	if (!equals)
+	if (!equals) {
 		*val = NULL;
-	else {
+	} else {
 		args[equals] = '\0';
 		*val = args + equals + 1;
 
@@ -244,6 +244,10 @@ char *next_arg(char *args, char **param, char **val)
 	} else
 		next = args + i;
 
+	/* Treat blank param value, e.g. 'param=', as NULL value. */
+	if (equals && **val == '\0')
+		*val = NULL;
+
 	/* Chew up trailing spaces. */
 	return skip_spaces(next);
 }
-- 
2.25.1.481.gfbce0eb801-goog

