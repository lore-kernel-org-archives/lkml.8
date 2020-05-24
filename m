Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4EEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 00:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866E52077D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 00:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGK3jObq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbgEXAkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 20:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388106AbgEXAkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 20:40:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA8C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 17:40:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y198so6987972pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=v4d4ISfjUvIFvHJuALETvgiIbZuG6462V+CJxwK89z0=;
        b=KGK3jObq/Rwqq8KeUundU5/ZBV9GnwTXRDtlyxSM5ipoMWY3Xl2OzkzpGlsDYd2qpj
         7ANBcvK/20y+8w8+ZNGpvUMqvEH2MbdMLlYqpjP/NiXUfYnXlCt3KwivZ5QktBQqN/QP
         kyxRUVddRPH2YXvqGKFwx52wk7cOrL2kBrMCRw0sHkcu9644gTZK0KX2EAxZPOKM8pKP
         9miHX4Pkcd97wuj4mSccKq9FitA/qRnZS6qQty4THzb4j5bcmwcjDcvE5RINjMiknfZq
         EtB6sXF4oTlX1PBE74nh7ekHLoetL0n3PMAz719Jbg6njj1ruvLffteWsBI0qe3/0mo0
         SO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=v4d4ISfjUvIFvHJuALETvgiIbZuG6462V+CJxwK89z0=;
        b=VyLqDcaLRZ7nlN4zNNEVcDwalf6RQINfi1eUghE2n9WSSBUdR6IW+l+BP4HAvfy8LO
         qelVuB5uScD/4TWkNHa22TjPzVhMtCNoot64YWp0MgmhJuiUOGovBWN1KZmN4a348wyL
         hRZUqAPorYjnsDncITlPdLgVatXQvRsibYjybigvU/p76vasg7xVrlbOfZGD/zsXMel0
         q6Vy8S+W3Sdz9mbgZ30HIOAcHplKZA6RJ3ZrARqxOuN/ydSuQOvVogjm++sNB2xj0BCW
         gahDBYv0UXVarcM2vxcAdJJ8uW/bu9QoC43Cpf6ogjdnZCfiV9/jfILt1g4kUFQ8VB42
         K/WA==
X-Gm-Message-State: AOAM531xJoS/Vx3GEEer7VxVNTJt04W2l4jcutyahL4Vah9hfD1W+Wwy
        tbJ80WXNFAsmCx46N7nnglo=
X-Google-Smtp-Source: ABdhPJy0kE/yD99sX3juFkNJli6/lc6t3ADHzatkTJPHA/0p0HGodd1CdlNlnWGoz5bXhV+c3dsYLA==
X-Received: by 2002:a63:1b46:: with SMTP id b6mr8682243pgm.429.1590280808063;
        Sat, 23 May 2020 17:40:08 -0700 (PDT)
Received: from [192.168.86.27] (c-73-222-199-61.hsd1.ca.comcast.net. [73.222.199.61])
        by smtp.gmail.com with ESMTPSA id g17sm10032811pfr.85.2020.05.23.17.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 17:40:07 -0700 (PDT)
Date:   Sat, 23 May 2020 17:39:59 -0700
From:   Hill Ma <maahiuzeon@gmail.com>
Subject: Re: [PATCH] x86/reboot/quirks: Add MacBook6,1 reboot quirk
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Message-Id: <NI8TAQ.QW9573GROMFS1@gmail.com>
In-Reply-To: <9Q40AQ.AIBOX7WP0C792@gmail.com>
References: <20200425200641.GA1554@cslab.localdomain>
        <9Q40AQ.AIBOX7WP0C792@gmail.com>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


gentle ping again and happy weekend to all :)


