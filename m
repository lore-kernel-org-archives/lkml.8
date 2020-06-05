Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77277C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492442053B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bho7QB/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFEHpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgFEHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:45:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EEC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 00:45:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k26so8092838wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yb3zMGauA29aZkgShwZMDaQu6XVMKRQQbZGZg871WuE=;
        b=bho7QB/FCpYdh2T7qkzNixcXGreNb633xxsS5i6OXvV+chd+CqXWFCbQzCZ+me41P0
         jRjwtK6AWsqwx4RAvqtk1mPssgApmZfJVkDazeZUOfnFUGhY6v2GS3B233E6ORm3IdS/
         KWQExTN9us4hOcV2NCFIiTsZ9760XmbCVbmuaika/t4Y4fUTjfY/ZRFltpena5BxBZoa
         g72xK4sye5mw0AyZCMlUePzlIRZpO6u7Q0Uay2Y3zmuFK2O5X9wKTR0H02GDyq6aaDrr
         QpAo5pvYvp9kHwZT8TKdhpZN7LQLd4QecZmebOMxoBFcxi4/8/qIPp9GMXHNIuWdbSvl
         OmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=yb3zMGauA29aZkgShwZMDaQu6XVMKRQQbZGZg871WuE=;
        b=LT8RODJ3ikdZ7HwDRHYOgG8GYpgEemH1TjVyOXtSZwykQLw/FpYv4DoU5A7d7cmjx0
         91W54OmYAGatS5puOelIMUOf5ZJ5CW+ZbAzR7WfNtUChO77oejDUcTEsQIUk8B+8enXX
         6xKLUw3ES+z1SOXWCtDJojk8W3wh4RZJVYmwcl7zVoylzI9wKPEv4vaKbEJYYvudYh9j
         3Astxi2uU6SC6BGrAcn2PTuPR/Hpi2cVfJW1uOcOsukN3tFSZPDqHD7PK36ng++HQAcy
         +UHCokWJEKlP9htEggyipfnb3/fW9eIxJH3X5un/TOmGd47/m+K6BBy8XEpHZ0sM6FYJ
         iGrg==
X-Gm-Message-State: AOAM533hdzq/7ikymZnEbNxiEEt0qzuFtq/7RmQI7UgsNa7svAc6eK2U
        yUKRXGKq40Yh9YPZ+7K+xg==
X-Google-Smtp-Source: ABdhPJxpgVmsW2R5cE8ZQ/sshfFCfu9DU553j0z25W8mrVtQq2botkZLVI56GEs1B3kuyMqHtzS83g==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr1285488wmk.96.1591343152476;
        Fri, 05 Jun 2020 00:45:52 -0700 (PDT)
Received: from earth2.lan (host-92-15-172-76.as43234.net. [92.15.172.76])
        by smtp.gmail.com with ESMTPSA id x205sm11190212wmx.21.2020.06.05.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 00:45:51 -0700 (PDT)
From:   "=?ISO-8859-15?B?/YCAgISB?=" <jbi.octave@gmail.com>
X-Google-Original-From: =?ISO-8859-15?B?/YCAgISB?= <djed@earth2.lan>
Date:   Fri, 5 Jun 2020 08:45:50 +0100 (BST)
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, boqun.feng@gmail.com
Subject: Re: [PATCH 0/5] cleanups
In-Reply-To: <20200602164510.GH29598@paulmck-ThinkPad-P72>
Message-ID: <alpine.LFD.2.22.394.2006050844350.4212@earth2.lan>
References: <20200601184552.23128-1-jbi.octave@gmail.com> <20200602164510.GH29598@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jun 2020, Paul E. McKenney wrote:

> On Mon, Jun 01, 2020 at 07:45:47PM +0100, Jules Irenge wrote:
>>
>> Jules Irenge (5):
>>   rcu/rcutorture: replace 0 with false
>>   rcu: replace 1 with true
>
> I queued these two, thank you!
>
>>   rcu: replace + with |
>
> This one I am not all that excited about, so I am leaving it off.
>
> 							Thanx, Paul

Thanks for the feedback.

Jules
