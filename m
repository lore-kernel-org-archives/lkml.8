Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BDAC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15F42063A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bovi.onmicrosoft.com header.i=@bovi.onmicrosoft.com header.b="1KyrZffg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504499AbgDNSyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:54:37 -0400
Received: from mail-vi1eur05on2105.outbound.protection.outlook.com ([40.107.21.105]:38081
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732442AbgDNSye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br7xfqOxWtTeJAOowoczLGtCBhCLs+XBtlRdR3l7/KstgZJAl1vb++zmMO3QMl5t0RyzPP7E3LpgIouXwl6kIdnzOalgQKnAM02ZTS8WARNbTwx75WxrQIBwDx9ZxuvKBx3dnY/9ad5THJgvp/4avRhQID4EBiyeqWo8ehBzjVVaz7yyI9kxYwyY/QEPzeNC8zztSNAkrF0FLuB8ElzyUgUBwDjb2w8HSOF3bsH1By6I6ro5StcENBG4eAYMejb+COx0KoKIkBxw/AH5OpTvzZejIuGdpx1KaTF0jxTfy8f9mVNyeeiI9SghlUaz3gkunW+4Gxmtn6hoAroU1OgjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPeHLjuEeNWM5wgqq0E1k86X8yLY57lTDX+6Ayaya/Y=;
 b=a5gR2D9u51EiwQulWPKSbFiGbFS8ZrE8IzX5vkIWFTV0kTzhojSw3f73NwNZtnCNUAupjots1LsUCjnH6mMG9ClBil7uQ+kj2XuKM/dJsQE7jTQqZO3xcrR8dY+6ilWHpCNAeWztywIOBaEyWuxhbiV5k51LBk6xKqTZ4ZI0nfM6yo9ASl1xjxjJYh8OUVtNHrAPw9fAenXYQ84kWKoO6qq8uDiDcXqYcmbnjMFqdTZ3ATKQIuOm95555AwLB4vd7X7PM6VMikLBHcmZ/zdh3uGx9AFXwupIVk3xCiJcCNog/yjCMte1vvS9HZGu8StsPYmg1Ghj1h5NfeiO+9x+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bovensiepen.net; dmarc=pass action=none
 header.from=bovensiepen.net; dkim=pass header.d=bovensiepen.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bovi.onmicrosoft.com;
 s=selector2-bovi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPeHLjuEeNWM5wgqq0E1k86X8yLY57lTDX+6Ayaya/Y=;
 b=1KyrZffgYQvn11qniPSwLCcLuJIB+U1kuAa2U/LpjZlRgidyos+liPC03tgHqqYZUguK1TmcQH1UVbrY2JnmiJFnFFrjRQQc5iutHwKTMiZBVveASf3BlnlKA+oxr1caP0mtoPCKLFgt3naqNkL3v82NOODvM8hqwmC3DNaG2lY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel@bovensiepen.net; 
Received: from AM0P191MB0771.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15c::9)
 by AM0P191MB0546.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 18:54:31 +0000
Received: from AM0P191MB0771.EURP191.PROD.OUTLOOK.COM
 ([fe80::8495:e73a:ffdf:cf32]) by AM0P191MB0771.EURP191.PROD.OUTLOOK.COM
 ([fe80::8495:e73a:ffdf:cf32%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 18:54:31 +0000
Date:   Tue, 14 Apr 2020 20:54:30 +0200
From:   Daniel Bovensiepen <daniel@bovensiepen.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: tools: string.c doc fix
Message-ID: <20200414185430.GA14496@daboVM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AM0P191MB0771.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:15c::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from daboVM (91.66.30.126) by FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Tue, 14 Apr 2020 18:54:31 +0000
X-Originating-IP: [91.66.30.126]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9644ac46-f071-44d5-113d-08d7e0a5445a
X-MS-TrafficTypeDiagnostic: AM0P191MB0546:
X-Microsoft-Antispam-PRVS: <AM0P191MB05466D6C5ACD15545EF306D9D4DA0@AM0P191MB0546.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0771.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(346002)(366004)(136003)(39830400003)(376002)(4744005)(86362001)(33656002)(1076003)(33716001)(508600001)(6916009)(9686003)(81156014)(186003)(26005)(55016002)(6496006)(4326008)(16526019)(8676002)(66556008)(66476007)(8936002)(316002)(2906002)(66946007)(52116002)(5660300002)(956004);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: bovensiepen.net does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKQbqcGP6mkg7yimX/42LtQnfAlPdM9ODp1Axi6J7zX5bj9b9e0e1LGaERH+rnUonPMJ7nlpadPx1l8ZVrFYqMDtI0oFGqFAh9Lu3zSu8eSFcpq6qJAf7BsStOQE8xKMWDX/grWEs/PQP/VijCv9YypJ1VnwrlFDenOZj4gAc5XHlU5OyKSgnHY8V4/kznJ8wx1wWVBTU4BFI4qyEz1CquFUzYIATOEqFBObVGzBZRyfdET90HRrQrjnSi8Nwgs6V7pClYyxKdwtRJG69W0OsuOdSbfcnFBWj1fw7YxvdVRQeirp5Zz1lhRx0b9of72v6lHgKAXKc9g5sd86+uvPsyQmDzrSrKfk+3A4MKrjbZKk6arWZPxZZLssSCa6sEspMJuLuKw43U8q5Oz2Da+KpGYlW25AZiQaMvkHhI8I4OAenOqxePeA9o549pOGTRPX
X-MS-Exchange-AntiSpam-MessageData: g1XE71HhNPCMAfYgdbdmzXchy++sVoCWjP9TpCifuPJlbAIIFhUdPqtYXJmJZE78E9zZSHcu6vFsZXYF6RILRLGvrs6K5sbcVlrkMZgUMD/7dEJI5xWEo1KHRKhxgdifg81A9hKmlZ/I80r/+n1DPw==
X-OriginatorOrg: bovensiepen.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9644ac46-f071-44d5-113d-08d7e0a5445a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 18:54:31.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 66f9801c-3e1e-402f-a0bf-b23980f5c9a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rucvxevw9VCc4aroM6yC4V/bi1iMUKrx+1gqeZNwz+ZQHDYOyFDhtIMrszvNSYdF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P191MB0546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling error in the comment.

Signed-off-by: Daniel Bovensiepen <daniel@bovensiepen.net>
---
 tools/lib/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/string.c b/tools/lib/string.c
index f645343815de..f73a1020fad9 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -41,7 +41,7 @@ void *memdup(const void *src, size_t len)
  * @s: input string
  * @res: result
  *
- * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
+ * This routine returns 0 if the first character is one of 'Yy1Nn0', or
  * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
  * pointed to by res is updated upon finding a match.
  */
-- 
2.17.1

