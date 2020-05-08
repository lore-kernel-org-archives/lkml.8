Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED724C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CE8208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NBkcLO0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgEHLKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:10:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:34870 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgEHLK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:10:27 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200508111025epoutp02369d5e635db60161553a0f4bcede7ca7~NCRQLwNMo2624426244epoutp024
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:10:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200508111025epoutp02369d5e635db60161553a0f4bcede7ca7~NCRQLwNMo2624426244epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588936225;
        bh=nlTpk/H2W524JeoMjwxLHeoS7ljOS+hT9r9i64tVNAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBkcLO0zqkO+/pGNhdc+egm6J2CaFSjN6SZRMQxxoXNOt4FW1Vp4PdyLeovnZoB0G
         j0HcfpoJBMPLOqpEL/hw7HbYAR/fN37GjV7HkRHZSkqHRXlrwgiXswOTCi9I+6tY4s
         1JcZrmNPgLOo6nlGQYdpjPvN4KhkA/fE+/L/y2Bg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200508111023epcas5p13348856b7470edb50aef4b95811427dd~NCRO_c2ut0784107841epcas5p1e;
        Fri,  8 May 2020 11:10:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.FD.23389.F1E35BE5; Fri,  8 May 2020 20:10:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200508110359epcas5p19f9e7bdbd7a9c2880308f5201f6badc9~NCLpYJqdh0864608646epcas5p10;
        Fri,  8 May 2020 11:03:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200508110359epsmtrp10ea6193c4630a0d329609a82b6917904~NCLpXclpS2005420054epsmtrp1-;
        Fri,  8 May 2020 11:03:59 +0000 (GMT)
X-AuditID: b6c32a4b-7adff70000005b5d-d1-5eb53e1f9f72
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.FA.25866.F9C35BE5; Fri,  8 May 2020 20:03:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200508110358epsmtip246be8f9e8ba1e0b2b0dbf32081ead88d~NCLnwGW-e2981029810epsmtip2F;
        Fri,  8 May 2020 11:03:58 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     yamada.masahiro@socionext.com, george_davis@mentor.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        arnd@arndb.de, ak@linux.intel.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v2 4/4] scripts/checkstack.pl: fix arm sp regex
Date:   Fri,  8 May 2020 16:33:17 +0530
Message-Id: <1588935797-7283-4-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCmlq683dY4g47DRhYXd6daHJ9gafF3
        0jF2iyf/v7NaXN41h83i8Pw2FotDJ+cyWuy995nRgcPj969JjB7zTgZ67P7axOjRt2UVo8eJ
        6d9ZPD5vkgtgi+KySUnNySxLLdK3S+DKeP20j7mgg7OivymggbGdvYuRk0NCwETi2IWDLF2M
        XBxCArsZJdpeLYNyPjFKnNxzixnC+cwosWPnXFaYlv6XG9kgErsYJWbMPQrV8pVRYvvVv8wg
        VWwCehKrdu1hAbFFBKwknm3rYAOxmQXWM0qs2cwEYgsL2Euc2LodLM4ioCpx6+tjsHpeATeJ
        bx/2s0Bsk5O4ea4TbCangLvE7PW/GEGWSQhcYpc43veLCaLIRWLr50ZmCFtY4tXxLVDfSUm8
        7G9jh2hoZpT4tG8tVPcURomlFz9CPWQv8bq5AWgSB9B5mhLrd+lDhGUlpp5axwRxNZ9E7+8n
        UMt4JXbMg7FVJVpuboAaIy3x+eNHqKs9JJqezGGFBMssRomGyQ2sExjlZiGsWMDIuIpRMrWg
        ODc9tdi0wDgvtVyvODG3uDQvXS85P3cTIzhJaHnvYHz04IPeIUYmDsZDjBIczEoivBMrtsQJ
        8aYkVlalFuXHF5XmpBYfYpTmYFES533cCJQSSE8sSc1OTS1ILYLJMnFwSjUwcTzveMSb7zmt
        TvFWpv5HpRfeJbO+7XiqvmjvPgPFynCfQu3KyTHZrRWFV2QZt4Y0ebApzpNiV1z3ieta3Tu3
        g85KKfyFe29u5Ay9zvf2RtpvX5FZIrsOq9xbddXNfl39FasJJ3zFOPT0pi35br5f5Fztnvjm
        eT2nKuboLj+5x3vOHY1Ntfxml8SkDdPqHT6lHLqn8GHBpYAgef4pVzVnnlp26Kme+ttOpmB5
        n4YT+j0Si3Q/MEvfMWMIN3dl5ebX+XS+Oqt/t9Sn48smS83I1j2azXrY+1HY1dvCewzC35uX
        Wn3UFV3ea7/uv1XRe6X37HYzLSWeHJ++lnWGpPL6J+clg2zZ8p7pdMj+WNCuxFKckWioxVxU
        nAgA7L4mzoEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSvO58m61xBh+vGllc3J1qcXyCpcXf
        ScfYLZ78/85qcXnXHDaLw/PbWCwOnZzLaLH33mdGBw6P378mMXrMOxnosftrE6NH35ZVjB4n
        pn9n8fi8SS6ALYrLJiU1J7MstUjfLoEr4/XTPuaCDs6K/qaABsZ29i5GTg4JAROJ/pcb2boY
        uTiEBHYwSlw9fhwqIS3x8997FghbWGLlv+fsEEWfGSXenNvBBpJgE9CTWLVrD1iRiICNxIkT
        E8CKmAW2MkrM2tfCCpIQFrCXOLF1O1gDi4CqxK2vj8EaeAXcJL592A+1QU7i5rlOZhCbU8Bd
        Yvb6X4xdjBxA29wkPi0qncDIt4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAI
        amntYNyz6oPeIUYmDsZDjBIczEoivBMrtsQJ8aYkVlalFuXHF5XmpBYfYpTmYFES5/06a2Gc
        kEB6YklqdmpqQWoRTJaJg1OqgWli377Hdguinv3tuLPcr2a135FvscxcX+bzvPQO/V1V8m7J
        rnLXhimBRh9//ntd5/Ehc83N24YTuFmqetIjr/C/ePyAUXj7f1ujtJptPw8pLjr34hbLXJsU
        xRteroaFifzrPHYc2eV0REOZdZK/x9xzy+ZbTjM9MtnIU523ND+R5UWd2EzDqKnc1/msrLJ3
        /T70fO2tzj3Zy2e93Hhy18oPB2yTYj0mLwvk5zURM+XYpur9X2zx4rz9uo8+RdWbSZd9mTzr
        luZT1pQM/72qp4NDplTEnGXUmWX+YUnzQa71n/fFaATbPZm/vumZtfTeUzW34w5tlpV0Z9+2
        5H3UYxtOgw83ZA/s3scrX7I/5NESJZbijERDLeai4kQADn6wNrACAAA=
X-CMS-MailID: 20200508110359epcas5p19f9e7bdbd7a9c2880308f5201f6badc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200508110359epcas5p19f9e7bdbd7a9c2880308f5201f6badc9
References: <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
        <CGME20200508110359epcas5p19f9e7bdbd7a9c2880308f5201f6badc9@epcas5p1.samsung.com>
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

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 scripts/checkstack.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index bc07e19..d2c3858 100755
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

