Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8FC8300A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8380F206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="gIOzlfEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD1LRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:17:16 -0400
Received: from mail-eopbgr750058.outbound.protection.outlook.com ([40.107.75.58]:2736
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgD1LRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:17:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMWWeQKFxFVUnZrPGzCXrvuqbWAWro6ljvim0vPSxKEIIn8pwZ8yuw/NosIJQA46384qNHYXchpjFvuuRUuWzh6G3ms9RFyvLnYmBDyc6rOj/AMTFPX2gIVIJs3Rc6HY8sRBKkT2EMaiNsc+ooHNmX6ooR9hTtfTKglpIURLAnQ3vqcpth0/eGyXJCFFOO29dirnox1GVMTkFwK6YJbVrAgSrqNY1dKoVShg2a2VYiQHZ1R3lciIo3fcfKibgGo25D0AYoZQSfcHV3KBNpLyi4Wfcn8DlJNKAxsWKAV618/IgXoue/FdkvGHmoh05rFrCaxAq08emvop1fMrgBbVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlXsg5y99bP88jZsA05ekSXbyLV+K3+CRPQ04r0YxdA=;
 b=PKYZRgE6HrnSJztS7DF96ZBhU/KN2vwmQk1XChEE3ZQSuIflekrS9uTyqFmrFqwXUSUhIich8AQ7k63tv0IvagdVBCoe/GrRSAxUrWaCMe391sYdE0O+9/p+q9IAKrMMYpG0pNwcyx6JIjyGbuWYP6rs3ObEbQcXsKaoEzC3K8TSixRpMj11qX8qJIt7f7bxc79/sulMQCz4+t3So/ngCo9xYI59XMT9yfTy+5qPC+zNnjGNNjJxJsHML4/wX4oWzUV0ZErbvztWQB7gMW/3tqB8wzAGnTFyQcSuoUyJ/fY8QEdRo1Kthh/WaxzIgznJLhQ3z6Gn76jo4OMWUshUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlXsg5y99bP88jZsA05ekSXbyLV+K3+CRPQ04r0YxdA=;
 b=gIOzlfEW6ojnS0cZnn+NKM042GT/my6EDYQTdw503/nhF6NFrzp7GiLyhDwTJrrQi0FrGPKUuKpx4bKN78uyVP2xd88ELMHJufB32AjSOc/gDy2T4xgtR/3eHQGUlW5jYHViuSZLKLgZaPJXZ609E++nrREnwvC2lUwMcK58Bps=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BN8PR13MB2611.namprd13.prod.outlook.com (2603:10b6:408:81::17)
 by BN8PR13MB2737.namprd13.prod.outlook.com (2603:10b6:408:88::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.12; Tue, 28 Apr
 2020 11:17:10 +0000
Received: from BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929]) by BN8PR13MB2611.namprd13.prod.outlook.com
 ([fe80::c129:8fca:5ed:8929%6]) with mapi id 15.20.2958.014; Tue, 28 Apr 2020
 11:17:10 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, atish.patra@wdc.com,
        devicetree@vger.kernel.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [RFC PATCH 4/4] dt-bindings: net: phy: extend dt binding for VSC8541 ethernet-phy
Date:   Tue, 28 Apr 2020 04:16:48 -0700
Message-Id: <1588072608-7747-5-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588072608-7747-1-git-send-email-sagar.kadam@sifive.com>
References: <1588072608-7747-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To BN8PR13MB2611.namprd13.prod.outlook.com
 (2603:10b6:408:81::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BY5PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:180::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.9 via Frontend Transport; Tue, 28 Apr 2020 11:17:09 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b9bdea-920e-43c8-2df9-08d7eb65b1cc
X-MS-TrafficTypeDiagnostic: BN8PR13MB2737:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR13MB2737D3B982CF3CD16AB5302399AC0@BN8PR13MB2737.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR13MB2611.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(39850400004)(366004)(136003)(186003)(2616005)(52116002)(16526019)(7696005)(2906002)(86362001)(36756003)(26005)(107886003)(4326008)(5660300002)(66946007)(81156014)(956004)(66476007)(6666004)(66556008)(478600001)(316002)(8676002)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RceVEMrliac0AWB2yYqQN1yG/nWwA5qfKUhelUi6KnusEkH1d0UiL8RZND7nmAzivYa2Lt/H92HEbnvCye2WEa5WEJbg3Y1mq7+oJnb4bi0oXajpDq+SCUQNMf3p+PtWplrOG3D/iLoXnT+uYE6CRMqrkVjQOcO/BcFy1PY4LVuuM2qoG0HFPCDkn7ZTMViHaYOmnHKsDGktrmdfUICElOeKj6pl5ClBjzFX0qtRJsbslEsXvQeLlaqA/7eDjD8nYaPSEQo4X645nbb0EaOEy8I6wCJ7f5/OJuCX9VFxI/b8qzFRYCoKfziSyyGgaI68uxMUPo3G83acEa5yr2YUGQf55xzdIucrbAXSubTjJ1EJj1qhfjJDi3RIrsAalXTyLvxECDsGJOubFj4tt0ssb0zoflU9E/0ABZXKQ1Wm1Qlu/PKCRnwVOPFnXeJGh5t
X-MS-Exchange-AntiSpam-MessageData: /H9eNdMF2t/7MeFPdAshoBxfvm0eXfGNoPgUz+som8nXvrkdqLlboJfjXFrY76Gb+nYb0fAcRAsUg94nU1zypSHk5/qwRT9HtIJKARnlX8zQgB/QXexmltATEhPWWChTD0QuUuLRtWUMYp2jL2S1huZMUjiAVjOhSoFdxpV5GOf6oGCcqbfIEzDLAylT7SQ9dzJ3SqJVkq1uvXcUA8ANuKmG3RbzYIDz2HN6AaYQd6exRED9CWb3XBFrryaqnkbhdQ0aHRIIhHxjuUkjIxpEkYac4dXizjY6BXL4L5AEmamTgVjMuNJmjMMeZDfpNJhF7oZ9KIdt2KVtb7kdYFv1gDaOso74WxTrUi1ew+aohBCgvh7GgCWqrTmKDT2wY5c44LyBtz3nvXJbGH72gpXqVGjL65zEbX/qK+dIuAw8YdqLTKmJHoa+sV/9PLIRqmtp2YZOazxd7q7TeGtyvrXiDFBeeKz5OGVHQd+vf9dra8a2/st44Rn5nUEXUOy0EIj6lMP0A2SEhWwT+Wn0WAN2GQG3OlfAVsJZfvs69nz1GhxOnuQfc0uFmb3LBekN8a2nfyFZM1BVipe1LNfN6nHsMGm/I6jPlk0Obg9EK3hovdVeBZHRbxHn3WWd3jBwDmWhdfR/lhtKCxz4TIW1+lTea13r/y6XdWIn0x7vz5He/ueFZCNZmqXdRaIFcwTTnykfr4qDruDDrxCygarT0gqjUOf7Ugd2Fk6RF7hopCDghvly1hi9KuAVMBA18cdV67eqHikrNGpU2RVYzXxwEvpbWHiAeFb6wI0lGKg5cTaWVkM=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b9bdea-920e-43c8-2df9-08d7eb65b1cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 11:17:10.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6QHR7mJ2HvMJFs/EL9IacAXBBrSN5dbqmdMn3zK1gqpVDr02/mppclnSdCDD6DJ/9Vhh/VsNbCHJKvU+U6ZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a OUI (Organizationally Unique Identifier) for VSC8541-01
device to dt node requires a corresponding dt-binding entry as well
so that checkpatch doesn't complain with a warning:

DT compatible string "ethernet-phy-id0007.0771" appears un-documented

Here extend the existing dt binding of VSC8531 device to include
VSC8541 device example.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 5ff37c6..774448a 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -68,3 +68,6 @@ Example:
                 vsc8531,led-0-mode	= <LINK_1000_ACTIVITY>;
                 vsc8531,led-1-mode	= <LINK_100_ACTIVITY>;
         };
+        vsc8541_0: ethernet-phy@0 {
+                compatible = "ethernet-phy-id0007.0771";
+	};
-- 
2.7.4

