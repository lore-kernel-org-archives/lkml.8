Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC4C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83CC248E7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgDFP6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:58:08 -0400
Received: from serv1.kernkonzept.com ([159.69.200.6]:54131 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgDFP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:58:08 -0400
Received: from muedsl-82-207-238-172.citykom.de ([82.207.238.172] helo=x1c.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
        id 1jLU8N-00006d-4x; Mon, 06 Apr 2020 17:57:59 +0200
From:   Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
To:     xiaoyao.li@intel.com
Cc:     bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        nivedita@alum.mit.edu, pbonzini@redhat.com, peterz@infradead.org,
        philipp.eppelt@kernkonzept.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH v2 0/1] x86/split_lock: check split lock support on initialization
Date:   Mon,  6 Apr 2020 17:57:42 +0200
Message-Id: <20200406155743.206444-1-benjamin.lamowski@kernkonzept.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <30e141b8-f9c9-370a-4667-1e2f0116b6f7@intel.com>
References: <30e141b8-f9c9-370a-4667-1e2f0116b6f7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It's for the case that SLD is explicitly disabled by kernel params
> "split_lock_detect=off". You know, BIOS may turn SLD on for itself. So
> if user uses "split_lock_detect=off", we have to clear the SLD bit in
> case BIOS forgets to clear it.

Ah, I forgot that split_lock_setup() returns early if sld is disabled.
Thanks for explaining!

[...]
> If you really want to avoid the MSR access on the platform without SLD.
> You could make the default sld_state as sld_unsupported. It can only be
> changed to other value in split_lock_setup() when SLD is enumerated. So
> in split_lock_init(), we can use if (sld_state == sld_unsupported) to
> skip the MSR_TEST_CTRL access.

Attached is a new version of my patch that implements your suggestion.

Thanks,

Ben

-- 
Benjamin Lamowski - +49.351.41883235
Operating Systems Engineer - https://www.kernkonzept.com

Kernkonzept GmbH.  Sitz: Dresden.  Amtsgericht Dresden, HRB 31129.
Geschäftsführer: Dr.-Ing. Michael Hohmuth

