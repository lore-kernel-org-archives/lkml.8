Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A302C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240F320776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp5ms/fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbgEYAI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 20:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbgEYAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 20:08:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A97C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 17:08:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg4so1538583plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fLmpoD63Wkrg+yURw4XYTgo2n2dC+nGZvrliSW+tuR4=;
        b=kp5ms/fZdnITiLr0QTttnHAKSMMOOUv0WriqtUF+q7GmeK+tBB4av3vQ81fruRbfCt
         NQ0C520AeSsoxhem3ShPISe56m/LL8I1lVphkLs48w1TFLfan8f8qTrgfMh6ETzP+wr+
         ta+yyJQk+d8UXcQ6ZOeIe2yYD2qxl8hyznSg0A/s5up+ledXXxH6KywarHKtni6NqMJt
         ibF62IO8cFwzAXxDxzMLPSFyjG9OFFXUs1dmqa2Expm/iZkEfvzvkXHMwrsIvGOdlVnx
         LVqer2dd9BvjYIuCeHA7b/Jx8WMezgnQW4y8wha0c6EgbdBso5441RPjbgQTUzjhJ+Sq
         g+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLmpoD63Wkrg+yURw4XYTgo2n2dC+nGZvrliSW+tuR4=;
        b=O29USr1/8YNJffILdXclNVOni1RAuPJlQZs1Tlu9ez8Hov/1YyYh4IxE/tjIlXXpFX
         o2pYwRDezQT2D/b4PHfdOR47LJkdSokpu7L5AddfAzsZg/Jva81cgp4LMeSZkjE/MO8K
         HV+/Tz7J48dSbB8FRrHVH7qhSa2HFKq20p+bjwPJft8nmDYT30yF+wn1IG45wp17vFh0
         EdpJwFcqQEmOA7mQNg2HP6YMwXl7juWbCmIsbq+dEn2QAXFlXQclPiAm3onXP6wDXl2B
         fx3cspct+/TiurY0vG/4uLDz+YvO/5ddvCowte1GFrvjlC5Z+ZIngbqj6m1M5iFZiEN3
         Xq3w==
X-Gm-Message-State: AOAM530iI2ihvszKaCu8CqqS0U3YJdskvJ9kBFw60OYiO5KZ+AAx13tR
        GsEqP8JbazIpDe7MiVqMiNY=
X-Google-Smtp-Source: ABdhPJxYE6XVonT8hpej+vl0YGzZf0bRdm5Mmuna8txuSCikF+W6txzD9NAFUK3ZLDqgnMFvbB9Eiw==
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr12749123pjb.235.1590365305887;
        Sun, 24 May 2020 17:08:25 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id k4sm3644478pfp.173.2020.05.24.17.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 17:08:25 -0700 (PDT)
Date:   Sun, 24 May 2020 17:08:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: [PATCH v2] vt: keyboard: avoid integer overflow in k_ascii
Message-ID: <20200525000823.GE89269@dtor-ws>
References: <20200523230928.GA17074@pizza01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523230928.GA17074@pizza01>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 11:09:35PM +0000, Kyungtae Kim wrote:
> @@ -884,8 +884,11 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
>  
>  	if (npadch == -1)
>  		npadch = value;
> +	else if (!check_mul_overflow(npadch, base, &new_npadch) &&
> +	    !check_add_overflow(new_npadch, value, &new_npadch))
> +		npadch = new_npadch;
>  	else
> -		npadch = npadch * base + value;
> +		return;
>  }

So thinking about it some more, if we use unsigned types, then there is
no issue with overflow UB, and thus maybe we should do something like
this:

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 15d33fa0c925..568b2171f335 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -127,7 +127,11 @@ static DEFINE_SPINLOCK(func_buf_lock); /* guard 'func_buf'  and friends */
 static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];	/* keyboard key bitmap */
 static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. */
 static bool dead_key_next;
-static int npadch = -1;					/* -1 or number assembled on pad */
+
+/* Handles a number being assembled on the number pad */
+static bool npadch_active;
+static unsigned int npadch_value;
+
 static unsigned int diacr;
 static char rep;					/* flag telling character repeat */
 
@@ -845,12 +849,12 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 		shift_state &= ~(1 << value);
 
 	/* kludge */
-	if (up_flag && shift_state != old_state && npadch != -1) {
+	if (up_flag && shift_state != old_state && npadch_active) {
 		if (kbd->kbdmode == VC_UNICODE)
-			to_utf8(vc, npadch);
+			to_utf8(vc, npadch_value);
 		else
-			put_queue(vc, npadch & 0xff);
-		npadch = -1;
+			put_queue(vc, npadch_value & 0xff);
+		npadch_active = false;
 	}
 }
 
@@ -868,7 +872,7 @@ static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
 
 static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
 {
-	int base;
+	unsigned int base;
 
 	if (up_flag)
 		return;
@@ -882,10 +886,12 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
 		base = 16;
 	}
 
-	if (npadch == -1)
-		npadch = value;
-	else
-		npadch = npadch * base + value;
+	if (!npadch_active) {
+		npadch_value = 0;
+		npadch_active = true;
+	}
+
+	npadch_value = npadch_value * base + value;
 }
 
 static void k_lock(struct vc_data *vc, unsigned char value, char up_flag)


I think if we stop overloading what npadch means, the code becomes more
clear. What do you think?

Thanks.

-- 
Dmitry
