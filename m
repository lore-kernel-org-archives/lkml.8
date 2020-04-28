Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF49C83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80E3206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vB6BBBag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgD1BN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1BN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:13:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D5EC03C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 18:13:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so1402956pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 18:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Y3GGZmbxLoB4/ky/zvuMJizsm3y5Ahq0Z93yi1/mNik=;
        b=vB6BBBagJDNdjOQ1Uf4d1ItZKf/yfYwHY/Lx4bBn5067k07IaWYcjHV2b/uF0pmXv7
         oV6/eTOs1N6BYi+vy36uPtzNUOYAIsVpvjBX5lfLogz6JAzOwld2SA7HRWLoIJQCXRfL
         M2l11WtPwurHVLAY4oqywzmCJT1J4QaTfvxkdcLOQyz15hSid6YKP4TySrKfNf0gLM50
         blcQZ6QdcdSQzaKD4M/5tUqELAcaDSlv9hG3ah24B2+36Lv92gBNIX5UiDapmcJkWMsT
         naqt0aA/gek21E+dEEs7O5xEsCDGHxyXb8vgk07kBSJzBXSUqMPEisZfVZsiS+wjnx4t
         d10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Y3GGZmbxLoB4/ky/zvuMJizsm3y5Ahq0Z93yi1/mNik=;
        b=QCgoHxmEZc4T4MbS24Fh1NhYg7EW5MLmK70HLxwYPiNKg/4oDNpDt4cAMWlLaYD4hD
         8otYD5zuHKU0qcAR+6BrLUl6DCEeJ6PPlozguQvjTeuWnE0XlfFqqfvZMUHIwKAnOCJu
         910U3nriOIm9o1bjHbuBlScMj9shmd6T/3SH0HcrSC+31SjVVGPLL52Mv4Pi/D+yYdOl
         Z9hIbGJXrnTUB7PTIY48DhcHHmOHGrTrfaASy+HJ5cLBmplStmE0IVNDr/5zJ+mMXiLr
         vz1sheqiYWMXgr9br5Ppmc1BRgP0Hyzp4BJxkZ3H+UHmB/DXmzT64htPsCsj7xrE3LXh
         JvyA==
X-Gm-Message-State: AGi0PuaTmSecQgLwofomt2npGjDbPNSEy8lZTeczieJuegiEqgNXvQA6
        +Dxl/1fWDmwKjYbL7JVRxw8=
X-Google-Smtp-Source: APiQypJKpTSK6oyBac2PxQyt9jZI95zOC2NCXv9W9sAxO7BuYSp54SwYztJQt2SAqQcjCBedqNTXIg==
X-Received: by 2002:a63:d601:: with SMTP id q1mr2176948pgg.452.1588036405434;
        Mon, 27 Apr 2020 18:13:25 -0700 (PDT)
Received: from localhost ([203.220.177.17])
        by smtp.gmail.com with ESMTPSA id q201sm13892911pfq.40.2020.04.27.18.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 18:13:24 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:08:54 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC 1/3] powernv/cpuidle : Support for pre-entry and post exit
 of stop state in firmware
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc:     ego@linux.vnet.ibm.com, mikey@neuling.org, mpe@ellerman.id.au,
        oohall@gmail.com, psampat@linux.ibm.com, svaidy@linux.ibm.com,
        skiboot@lists.ozlabs.org
References: <20200427021027.114582-1-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20200427021027.114582-1-huntbag@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <1588035100.usm3gb816q.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for picking this up and pushing it along. I do plan to come back=20
and take another look at it all, but what we do need to do first is get=20
a coherent approach to this proposed new calling convention and OS ops.

It's fine to work on this in the meantime, but to start merging things
my idea is:

- OPAL must leave r13-r15 untouched for the OS.
- OS ops are made available only for a "v4" OS that uses the new
  calling convention, including kernel stack.
- OS ops baseline (all OSes must provide) will be console / printk=20
  facility, trap handling and crash/symbol decoding on behalf of OPAL,
  and runtime virtual memory.

Other OS ops features can be added in the versioned structure, including=20
this.

I'm trying to get back to cleaning these things up and start getting=20
them merged now. Any comments or review on those would be helpful.

Thanks,
Nick

