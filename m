Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E197C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077962075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amgWxDk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbgAXOZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:25:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387621AbgAXOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579875950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gFUS+IYpTMcPpriTfqC+Rs1/QtFWk7pC2ooCgkxv0Po=;
        b=amgWxDk292hKUeEXyajV2l+frm3Fh/3pfFqN6hQFHSpGH5ox/kWnKO2BA/F6LDgC+/S4nI
        Yu6w+dwFQ2hLEXS8xCgWc1VFGX7sMpNIaNeOUFl8VRSaRpiwRoipsWJc1PGof/Rk0862IM
        zIJE5SzB3TqutYDJOIEVNqTz/J2HD8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-8HkIZKcTMhqYNkxhYA9nDw-1; Fri, 24 Jan 2020 09:25:45 -0500
X-MC-Unique: 8HkIZKcTMhqYNkxhYA9nDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23DB190D345;
        Fri, 24 Jan 2020 14:25:43 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFFEC3B0;
        Fri, 24 Jan 2020 14:25:38 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc:     andrew.murray@arm.com
Subject: [PATCH 0/4] KVM/ARM: Misc PMU fixes
Date:   Fri, 24 Jan 2020 15:25:31 +0100
Message-Id: <20200124142535.29386-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While writing new PMUv3 event counter kvm-unit-tests I found
some bugs related to the chained counter implementation:

- the enable state of the high counter is not taken into account,
- chain counters are not implemented along with SW_INCR type,
- SW_INCR does not take into account the global enable state

The last patch rather is an optimization that avoids manipulating
non supported counters.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/linux/tree/v5.5-rc7-pmu-fixes-v1

Test:
Tested with kvm-unit-tests [1]: all tests now pass,
at the exception of one sub-test in pmu-chain-promotion
but this is a bug in test.

Other testing at higher level (perf) appreciated.

references:
[1] KVM: arm64: PMUv3 Event Counter Tests
(https://lore.kernel.org/kvmarm/c1831b6c-dc75-1bd3-6657-0375682c30af@redh=
at.com/T/)

History:

RFC -> v1:
- remove  [RFC 3/3] KVM: arm64: pmu: Enforce PMEVTYPER evtCount size
- add KVM: arm64: pmu: Only handle supported event counters
- Take into account the enable state of the CHAIN high counter
- revisit kvm_pmu_software_increment() implementation as suggested
  by Marc


Eric Auger (4):
  KVM: arm64: pmu: Don't increment SW_INCR if PMCR.E is unset
  KVM: arm64: pmu: Don't mark a counter as chained if the odd one is
    disabled
  KVM: arm64: pmu: Fix chained SW_INCR counters
  KVM: arm64: pmu: Only handle supported event counters

 virt/kvm/arm/pmu.c | 114 +++++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 45 deletions(-)

--=20
2.20.1

