Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF840C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA502074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CamT+Knz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgD3Mu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:50:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59778 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3MuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:50:24 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200430125021epoutp034a4873958146a7be843dbe982b5739ee~KmeObdvYe1425214252epoutp03v
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:50:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200430125021epoutp034a4873958146a7be843dbe982b5739ee~KmeObdvYe1425214252epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588251021;
        bh=XvoAcrdDzV2UmUfP6BOxdmUHBnWjCMOjcJec9NQuhck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CamT+Knz+w3AEykujAEJIbT/83aMUX1Yn9D2ybyEiJ/9nMqmxtcV0I84usX25sFIr
         s/UhDYq6WBidH7big0ogM1FUdv1/gmGYQwkUCxj5K2Pyd+CoLcwCA4+dQfYpNnDw1c
         3lgYwot16CnOpICduXwE4t1vZfcMDddQrrIRSD/c=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200430125020epcas5p4199ebe450e7c97f8807e27d748f485df~KmeN_FcCL0407604076epcas5p4y;
        Thu, 30 Apr 2020 12:50:20 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.33.10083.C89CAAE5; Thu, 30 Apr 2020 21:50:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200430125001epcas5p2a6f02e9888481cef96f32ba14450bc63~Kmd8QFFLG0801308013epcas5p2C;
        Thu, 30 Apr 2020 12:50:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200430125001epsmtrp19a0215e7ef2a71f62d6369820856522f~Kmd8K8vIy3007130071epsmtrp1d;
        Thu, 30 Apr 2020 12:50:01 +0000 (GMT)
X-AuditID: b6c32a4a-875ff70000002763-24-5eaac98c9fa0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.11.25866.979CAAE5; Thu, 30 Apr 2020 21:50:01 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200430125000epsmtip26f8ffcdd3f29dd37cd85a7d13fa8057b~Kmd6_D42y1751917519epsmtip2j;
        Thu, 30 Apr 2020 12:50:00 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     yamada.masahiro@socionext.com, george_davis@mentor.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 4/4] scripts/checkstack.pl: fix arm sp regex
Date:   Thu, 30 Apr 2020 18:19:32 +0530
Message-Id: <1588250972-8507-4-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCmum7PyVVxBseOWFhc3J1q8eT/d1aL
        y7vmsFkcnt/GYnHo5FxGi733PjM6sHns/trE6NG3ZRWjx4np31k8Pm+SC2CJ4rJJSc3JLEst
        0rdL4MqY/HQee8FFjoo316YwNTBeZeti5OSQEDCRuHxrNWMXIxeHkMBuRoljDe3MEM4nRok9
        1zazQTifGSV6F1xhhWn5fHkiC0RiF6PEywsXofq/Mkr07zzPBFLFJqAnsWrXHhYQW0TASuLZ
        tg6wUcwCXYwSq/dsB1rCwSEsYCOx8aoSSA2LgKrEn3/PwMK8Am4SqxZrQyyTk7h5rpMZxOYU
        cJd4vuA82BgJgV3sEjuuvmWBKHKR+P15CTuELSzx6vgWKFtK4mV/GztEQzOjxKd9axkhnCmM
        EksvfoT6x17idXMDE8hmZgFNifW79CHCshJTT60De4ZZgE+i9/cTJog4r8SOeTC2qkTLzQ1Q
        Y6QlPn/8CHWQh8T0RZ1gRwgJzGKUOPVXZgKj3CyEDQsYGVcxSqYWFOempxabFhjlpZbrFSfm
        Fpfmpesl5+duYgTHv5bXDsZl53wOMQpwMCrx8HJsWhUnxJpYVlyZe4hRgoNZSYT3YSxQiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOK8W48o4IYH0xJLU7NTUgtQimCwTB6dUA2PW4Ud8C3L7/vCz
        tci2vU4y8hEMvKUp+17wtsCjLzN3hpmUzfyhkBR/eOaCfSmN0b63fuR/YpzGkf39SnvdHWdO
        FYbloUb9kbfq+oKio88vKvb3ttpw1n2xS7nAF/GymKCUqekV/O++K51zZPZVsJcVsb5XKFB9
        5u2+4oTu2OBTjFynpdU4lViKMxINtZiLihMBB4e1efsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42LZdlhJXrfy5Ko4gw1tBhYXd6daPPn/ndXi
        8q45bBaH57exWBw6OZfRYu+9z4wObB67vzYxevRtWcXocWL6dxaPz5vkAliiuGxSUnMyy1KL
        9O0SuDImP53HXnCRo+LNtSlMDYxX2boYOTkkBEwkPl+eyNLFyMUhJLCDUeJe20GohLTEz3/v
        WSBsYYmV/56zg9hCAp8ZJRraU0FsNgE9iVW79oDViAjYSJw4MYEdZBCzQB+jxMIPE5m6GDk4
        hIESG68qgdSwCKhK/Pn3jBkkzCvgJrFqsTbEeDmJm+c6mUFsTgF3iecLzrNBrHKT+De9g2UC
        I98CRoZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBwaWltYNxz6oPeocYmTgYDzFK
        cDArifA+jF0VJ8SbklhZlVqUH19UmpNafIhRmoNFSZz366yFcUIC6YklqdmpqQWpRTBZJg5O
        qQamvmO+0j+rhC8aiLzkY71f0Lqcyew3w6t2/8plzZP62cOvJT1v4D+2hfvwn8JdC3Rl199T
        rDn31/BN3HvTH73yV1sj/k8vvBTG9+HX2w5GxyfSi80USmwnORl+YlL5lhswU+/5swb5vW9+
        a+y2WKyxSvdsvMfEjkS9yglaO04J+kw2vXKjUootVumn+YF8xehe2SXHHqUIPZ+2QWK6stoD
        U99pV1z+94te0in+1amVKJeyX6RQfbNISqWzO+MTIQHnjM8PexIeyP67fWCT+SMXqYsl22R5
        7OzvaGhKzv1S3/D2nNfKi0ZeKakCsxQfCsmbyQswzDGZPX17O5udRbznjo1/23XPxRjdNPn6
        y1CJpTgj0VCLuag4EQBXaHfbnQIAAA==
X-CMS-MailID: 20200430125001epcas5p2a6f02e9888481cef96f32ba14450bc63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200430125001epcas5p2a6f02e9888481cef96f32ba14450bc63
References: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200430125001epcas5p2a6f02e9888481cef96f32ba14450bc63@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if objdump has below entries;
c01ed608 <X>:
c01ed614:       e24ddff7        sub     sp, sp, #120    ; 0x78

c01f0d50 <Y>:
c01f0d50:       e24dd094        sub     sp, sp, #140    ; 0x8c

scripts fails to read stack usage.
so making regex $re for ARM similar to aarch64

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 scripts/checkstack.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index b292ef4..e80de70 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -60,7 +60,7 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 		$dre = qr/^.*sub.*sp, sp, #(0x$x{1,8})/o;
 	} elsif ($arch eq 'arm') {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
-		$re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
+		$re = qr/.*sub.*sp, sp, #([0-9]{1,4})/o;
 		$sub = \&arm_push_handling;
 	} elsif ($arch =~ /^x86(_64)?$/ || $arch =~ /^i[3456]86$/) {
 		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
-- 
1.9.1

