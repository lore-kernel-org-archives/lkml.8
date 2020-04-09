Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01E5C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997C420678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHgBJ/dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgDIRIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:08:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDIRIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:08:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id c138so5049064pfc.0;
        Thu, 09 Apr 2020 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qABVumhieKrODuYVGr+5avf5kX3MFltmBukZWdasrJA=;
        b=QHgBJ/dQVzrCWOojN7R5HC8DKaJQeEyFdMi83rlTNFrLmhANZp0vWCaQd2uzqnVsJ+
         u1tmH5gR2FXT3fTB71+7hP3gxbkkZ6GZua1PMlOnK86fNhs4wCHPJoMyZkY1CdecS/lu
         x4q2O4YON0OB7wRNZFMtUDC9BzSQfU27wCTD18CC4WYXowhNFQqD1Ko5m3YUc97J7quU
         5wBXqa3W4XH4BoGs8Kk7Z5+dm3q8lVh1gLMP1odTSLSZX8Sq46t7/BgPavaN0FUGeJ38
         QTXr8/rJrPhwTPX7TLZCrIvz6QOT6sjv4RwjD1KT/NmNihZTT2U4+PPTnOGPFo20iSXT
         cAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qABVumhieKrODuYVGr+5avf5kX3MFltmBukZWdasrJA=;
        b=eIYERsBB8bkI8FOQn3ocez6LIVu1F9deaJpITirPAYWU47aA0oDEKSBvfXHYhxYYIw
         j93W+dxz1ab4vfME7+MHwvZnbDEF2MOZO+LkYVs6MSXE5olcRijE+AoQ7GtTq5NSwadM
         dAiUWi+MgjGKNpXI/cLYEqbDKEFVnsn4jQBEFl9YKcERg+5iXnWvaB3SDALsRdWo3ouA
         WJHTm1gKnPMKAse8yFT2soaKRXsYuU/MaoXGLHeBRnagKu1W/0tvO636hbZZA91CjBwN
         S6Ca5WyeYT2cvPXIDIjhvofl0I5f3p18Id5hqQz5yMbhcw7XEZZjm8QOPNfDWpfCGFwp
         VHZQ==
X-Gm-Message-State: AGi0PuauAOPf8q4ihyDwSEYciz1QBgx0Cf0Q6SiJm/KAVSmIr3MYPMfn
        CMKB7iUZTsZlnPU9Cq2ouLc=
X-Google-Smtp-Source: APiQypKS/zEn3F46PtbMDxo32uzwW1KXI9xDUME2VfkTyb2gHu1HqAKtK0b3BW+lkAdAUuwAA6mfLw==
X-Received: by 2002:aa7:94b9:: with SMTP id a25mr519636pfl.193.1586452092095;
        Thu, 09 Apr 2020 10:08:12 -0700 (PDT)
Received: from localhost.localdomain ([2408:821b:3c17:6960:4f7:54ff:5542:dca3])
        by smtp.gmail.com with ESMTPSA id i187sm19682487pfg.33.2020.04.09.10.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 10:08:11 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     abhishekpandit@chromium.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, davem@davemloft.net,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        kuba@kernel.org, hdegoede@redhat.com,
        youling257 <youling257@gmail.com>
Subject: Re: [RFC PATCH v4 0/5] Bluetooth: Handle system suspend gracefully
Date:   Fri, 10 Apr 2020 01:07:42 +0800
Message-Id: <20200409170742.27865-1-youling257@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304010650.259961-1-abhishekpandit@chromium.org>
References: <20200304010650.259961-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cause a suspend problem on BYT/CHT device, https://bugzilla.kernel.org/show_bug.cgi?id=207169
