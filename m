Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8AAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C6420737
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbgDAUaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:30:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35770 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:30:15 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJk01-0000vF-O5; Wed, 01 Apr 2020 22:30:09 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A54DA101177; Wed,  1 Apr 2020 22:30:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters
In-Reply-To: <20200204161639.267026-1-peterx@redhat.com>
References: <20200204161639.267026-1-peterx@redhat.com>
Date:   Wed, 01 Apr 2020 22:30:08 +0200
Message-ID: <87d08rosof.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:
> @@ -169,8 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  			continue;
>  		}
>  
> -		pr_warn("isolcpus: Error, unknown flag\n");
> -		return 0;
> +		str = strchr(str, ',');
> +		if (str)
> +			/* Skip unknown sub-parameter */
> +			str++;
> +		else
> +			return 0;

Just looked at it again because I wanted to apply this and contrary to
last time I figured out that this is broken:

     isolcpus=nohz,domain1,3,5

is a malformatted option, but the above will make it "valid" and result
in:

     HK_FLAG_TICK and a cpumask of 3,5.

The flags are required to be is_alpha() only. So you want something like
the untested below. Hmm?

Thanks,

        tglx

8<---------------
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -149,6 +149,8 @@ static int __init housekeeping_nohz_full
 static int __init housekeeping_isolcpus_setup(char *str)
 {
 	unsigned int flags = 0;
+	char *par;
+	int len;
 
 	while (isalpha(*str)) {
 		if (!strncmp(str, "nohz,", 5)) {
@@ -169,8 +171,17 @@ static int __init housekeeping_isolcpus_
 			continue;
 		}
 
-		pr_warn("isolcpus: Error, unknown flag\n");
-		return 0;
+		/*
+		 * Skip unknown sub-parameter and validate that it is not
+		 * containing an invalid character.
+		 */
+		for (par = str, len = 0; isalpha(*str); str++, len++);
+		if (*str != ',') {
+			pr_warn("isolcpus: Invalid flag %*s\n", len, par);
+			return 0;
+		}
+		pr_info("isolcpus: Skipped unknown flag %*s\n", len, par);
+		str++;
 	}
 
 	/* Default behaviour for isolcpus without flags */
