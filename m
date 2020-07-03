Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6895C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A61A208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pz8std7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGCDS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGCDS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:18:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB9C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 20:18:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b25so31451684ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 20:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnMOmiMqg2WYRkuEFv442IXE+//Cr5LIjZGsSifmgGU=;
        b=pz8std7zGDPAzQbBHwIU8GQ9PYnki3vnQg1S+g8xcStJyQGOf7h9K2tjws4NQYZGVn
         KG+gviz7YmCOqXx/N7MmeNy+aFleVzwoqH2WbDjnomfwn6gePzftQrM62+nmZa2FtTgN
         3RPWN0kwjqNMvGYLXzy2bON6GrITj44PHfVeO+Rv4wkKVyU6mdbNZsnmfbmyyQSXwF+S
         eReoo3Tzt2k9gGnEUktUPKb20MqyGVaZ+vFpFro4FZBP+VqMYFMMluPQF82pBjnSBJ8e
         V1dvRqOAUpJHUYQR/LbT6oy8TKpsbqnkwACdXO6k/jzAm1YCry5i5JBmdwVekF+KP9xP
         G+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnMOmiMqg2WYRkuEFv442IXE+//Cr5LIjZGsSifmgGU=;
        b=UPRZMYWHbYBFshxSyGGR95jOWOipCbGXI2GNkW8yn69a+MUNgF0wesOLUBdl+bQVow
         Ks5QApRGwMf7YSsWhTjgrw9gtLV4F7igKKQKC5Nwhffrdduac7Bi5AzcoHJ9RlgntCfJ
         aJIvR4GjKYE/wYq0VzGRT6OBRNt/m6UpYEsJ/vRVSM4X3El+5dDr1/ewcFeTbOUR7ZGl
         IWyWRsdGaM+2LrkkzpLy+ax5JVIjAPqcRZE7KfBOTtareTokAvhv7kBCD1hy5v5nr7i7
         Z1rH9kep/us278/ReLlwIZfxG3IJR9ignyLoCKSZAfP1IxSawLqYCVPNIxvqLwd6Ete0
         Qdjg==
X-Gm-Message-State: AOAM530gquvqLqV09NS+eFt6BMTIAdiuz60gW9c77AmPEmSTg3vt7a1O
        SJr1UNuvxrZDUpYuWfTR6bVMe4sSaW/0ph91VD8aqwCkowH9
X-Google-Smtp-Source: ABdhPJwPFU+9EQTP5K1YXtpLPRAQ3J3q2LA6wf+jGVOsBO3Wr5BMBI8imsYtPUbefbuQhAsWeMrSO92HOLH3cKIYsqw=
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr16378986lja.117.1593746304544;
 Thu, 02 Jul 2020 20:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200702221237.2517080-1-abhishekbh@google.com> <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com>
In-Reply-To: <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Thu, 2 Jul 2020 21:17:39 -0600
Message-ID: <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/speculation/l1tf: Add KConfig for setting the L1D
 cache flush mode
To:     Abhishek Bhardwaj <abhishekbh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this probably requires an explanation why the change is necessary
or useful. Without that it is difficult to give some meaningful
feedback.
