Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77601C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461882166E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404076AbgDCSZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:25:09 -0400
Received: from serv1.kernkonzept.com ([159.69.200.6]:36311 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgDCSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:25:08 -0400
Received: from muedsl-82-207-238-232.citykom.de ([82.207.238.232] helo=x1c.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
        id 1jKQMp-0001aj-2Q; Fri, 03 Apr 2020 19:44:31 +0200
From:   Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
To:     xiaoyao.li@intel.com
Cc:     philipp.eppelt@kernkonzept.com, bp@alien8.de, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, nivedita@alum.mit.edu, pbonzini@redhat.com,
        peterz@infradead.org, sean.j.christopherson@intel.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 0/1] x86/split_lock: check split lock feature on initialization
Date:   Fri,  3 Apr 2020 19:44:02 +0200
Message-Id: <20200403174403.306363-1-benjamin.lamowski@kernkonzept.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325030924.132881-1-xiaoyao.li@intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During regression testing of our hypervisor[1] with the current git tip,
we got writes to the TEST_CTRL MSR on hardware that does not support
split lock detection. While the original split_lock implementation does
not exhibit this behavior, the reworked initialization from
dbaba47085b0c unconditionally calls split_lock_verify_msr() from
split_lock_init().

After the elaborate checks in cpu_set_core_cap_bits() this seems like an
oversight. The following simple patch fixes our regression by checking
for X86_FEATURE_SPLIT_LOCK_DETECT before accessing the TEST_CTRL MSR.

Please CC me on replies - I am not subscribed to the LKML.

Kind regards,

Ben

[1] https://github.com/kernkonzept/uvmm

-- 
Benjamin Lamowski - +49.351.41883235
Operating Systems Engineer - https://www.kernkonzept.com

Kernkonzept GmbH.  Sitz: Dresden.  Amtsgericht Dresden, HRB 31129.
Geschäftsführer: Dr.-Ing. Michael Hohmuth

