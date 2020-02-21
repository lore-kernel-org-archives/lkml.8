Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1495CC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7F720722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="HMPZ83NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBURyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:54:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55695 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBURyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:54:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so2656498wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xIoPJC89gVWFrNtFw0AHmOeVBRfBncDtaR7CYLx5/Dg=;
        b=HMPZ83NG9rwiQMFLrYVIV0XarG2yWBarAaYn0Or5vkNGo0gR6DPadrWYKJedIyWa/F
         VDgnkJ6P4JpsRgH8kGhl+10HQHX6TSvl9GyowzdP8yYq70W6phN5Cb63/hOdgQbcu6Tx
         YkdLfWx0HxrDj7fkgtG0WSO1onF1bWSHeJ8XdRiJqqE+rm1yLbOB6tSj6slBfjHUJA81
         ner9fe3wnAZCTC0/zTIXmNjLemvcjc0X77JXFfVN7cVJTwWQRgTCKw03OS58T4dQocCW
         OeqSWb+7aDsP0Bs+Azg4p85XZFNxPPM2WOX1NIg1ifNOQJRCrbbB/KUDp5Vkv4iw39hB
         wIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xIoPJC89gVWFrNtFw0AHmOeVBRfBncDtaR7CYLx5/Dg=;
        b=q0+erXVVwziiVaQp5EUkBxKICTyp81DYMEUppRcgy2Nai6dpdfMqkN4GgbD7xiYmcK
         dsQF6r07bSd/Z6PAI/p8KTWfGKj+6YTfQ+DNDR9V6C/oH3hQUs6YGDvoQRwOnK0y1qXZ
         0w++AA6W1zQGrUw0JrwM2t+otcHNgiUznS2mDID4XdfjRRXr415kTYNYOHo9EPnOWm5A
         4M00jV+FGhgvERYJnHnQdO7Vf7e4TKwjw8YxqFgNKDPiKMxEQ1UPnN7WMejHrGgQ005w
         qhh/wsNKKJcRPzQtjdBIKMWF/BaEtHju+VlZZ2PjcItW8Ld9nl1bZtuKDT1V+OwH+hZ7
         UgpA==
X-Gm-Message-State: APjAAAU4DU2n1zMsQdsqkP6DsgwRJo8bEWqmTLF8oH5KVCMR+sNbKRqh
        GlsOjwxh1QsmRZ4BKSwU/dtMlA==
X-Google-Smtp-Source: APXvYqyDP0cz6luS0Fl6H3aL1bf+0QT5FEG4EgdaFEKW3zTlqWaHiJiVlOY6fjWQWE7rSFcxzNOAMA==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr5079128wmj.147.1582307677644;
        Fri, 21 Feb 2020 09:54:37 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id j5sm4914621wrw.24.2020.02.21.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 09:54:37 -0800 (PST)
Date:   Fri, 21 Feb 2020 18:54:36 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     jiri@mellanox.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] net: core: devlink.c: Use built-in RCU list checking
Message-ID: <20200221175436.GB2181@nanopsycho>
References: <20200221165141.24630-1-madhuparnabhowmik10@gmail.com>
 <20200221172008.GA2181@nanopsycho>
 <20200221173533.GA13198@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221173533.GA13198@madhuparna-HP-Notebook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 21, 2020 at 06:35:34PM CET, madhuparnabhowmik10@gmail.com wrote:
>On Fri, Feb 21, 2020 at 06:20:08PM +0100, Jiri Pirko wrote:
>> Fri, Feb 21, 2020 at 05:51:41PM CET, madhuparnabhowmik10@gmail.com wrote:
>> >From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>> >
>> >list_for_each_entry_rcu() has built-in RCU and lock checking.
>> >
>> >Pass cond argument to list_for_each_entry_rcu() to silence
>> >false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
>> >by default.
>> >
>> >Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>> 
>> Reviewed-by: Jiri Pirko <jiri@mellanox.com>
>> 
>> Thanks.
>> 
>> However, there is a callpath where not devlink lock neither rcu read is
>> taken:
>> devlink_dpipe_table_register()->devlink_dpipe_table_find()
>>
>Hi,
>
>Yes I had noticed this, but I was not sure if there is some other lock
>which is being used.
>
>If yes, then can you please tell me which lock is held in this case,
>and I can add that condition as well to list_for_each_entry_rcu() usage.
>
>And if no lock or rcu_read_lock is held then may be we should
>use rcu_read_lock/unlock here.
>
>Let me know what you think about this.

devlink->lock should be held since the beginning of
devlink_dpipe_table_register()

