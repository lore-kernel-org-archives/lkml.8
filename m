Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76778C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FAF206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Kt4Y4d0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgG2FzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:55:00 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:60374
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbgG2Fy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLo0vq9YMjxvMxh6TAvdg5uKyzxARcrqv64bW/2WQRwQAUisOyAa9ijyrsHjulDerrLEJ9OyXGu5UQlJgofwTUsA+6GKubgi2qwJck4E7gIyUmGQ4+apHQe+ks7jdwI76rPeqwGz3AWRy+IM8u2dFH3XM/GiHtDdJvekEuq+zbQu2KGLQSJK9F3PR0IcN0dJA9yV5j0qG++ClDpaUdxA9mS0MgzM0nqaadApd77pbGiw3VyLlqM4X0z3J7UoZkR7wZUAz0VfruWUeq10grUmLwPMSiH4c4tuhi80MF9r/UEAYZSXUVIVE4+0omFez7hUI8Dy1cKG9otGzy+X8kcfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raM8drE0l/cYEsridPtBXi2vTD0LUhZQb90WDiwIk1E=;
 b=IxxDipDglFzd87EGZXgk0BKdUb7pEX1YccflJIEOWiJumXrK4Ea2Q0fv8BeyjqV7H+xPevSjz4I7rJ/juOcCuS25UmidEiiljXg0u79cJvo9iKZdl/aBuW2SPOkYGR8Sk1mmLNcH5qm+u5XP0cQ4JDmnfH5KCRtpJxBE20IIJREFUkIhHEoVecUtakUEVSN7fpQrfp7V8Uc1N7wIAnS2Pl/a7w0k+xP1pgBEom7DFd0oFJzpJ74q/+Sm1QfCNnnx4sdIYlQY1uky/1vAL2h0zWzrByIPfqCPxpyItB1nA8tOeVscY19M5aBcnMcFfZI17glNMW63RzRJeAOf21iyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raM8drE0l/cYEsridPtBXi2vTD0LUhZQb90WDiwIk1E=;
 b=Kt4Y4d0xsy1ToOcYO4lN5+o/KHMjSp18smNFkuVUAxSFN6IPTSr/W0zmPHiGbyV4tPo2HTTuNfFeQHY4Q+Kh/CkSDkNozfNPTrLoOXvcs5TVnhkwaK9V3GweZ4QSPytvxIWP1ERFyy+LLdC5hcgPuNYO2lgd2nPXBMHNxvTIcJg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB4273.eurprd05.prod.outlook.com (2603:10a6:208:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 29 Jul
 2020 05:54:55 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3216.033; Wed, 29 Jul 2020
 05:54:55 +0000
Date:   Wed, 29 Jul 2020 08:54:52 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200729055452.GA31247@mtl-vdi-166.wap.labs.mlnx>
References: <20200728060539.4163-1-eli@mellanox.com>
 <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
 <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
 <ef857921-4b9a-8e48-d5cd-5ef585e8f15c@redhat.com>
 <83eb3fdc-83d5-7f88-bef4-602e60c19662@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83eb3fdc-83d5-7f88-bef4-602e60c19662@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM4PR0302CA0036.eurprd03.prod.outlook.com
 (2603:10a6:205:2::49) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM4PR0302CA0036.eurprd03.prod.outlook.com (2603:10a6:205:2::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Wed, 29 Jul 2020 05:54:54 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc2d598f-db3e-45ce-e0e8-08d83383eb48
X-MS-TrafficTypeDiagnostic: AM0PR05MB4273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4273C6A638A499CED7B5EA00C5700@AM0PR05MB4273.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdPtxtu1c1mm2bjBpCBCncqCpfsYdq9BZRjPmufAx/Ezml1yWnptq2o73jdemiuPE15esWA1f+nv3ESmgVEVfszTosIkZkYdNvFSylFNKjeMtNRCRNPdDFplkZG/bDmSaL/tMxz3O+s4ToZeqjcu8JGQD78YDMo+wdD/+GkcBTNj5PZpLSkgdjEyCGulN1H01SyWgRiaWBOaQEsfSuJwT7UjCo+hvNClNZNbeyNmL2w/e42BlNsgF46/5JMDIh2YgnH91tY3pm6T6xm5q5IdYHGajgLowAP5eozY1SwKTHWHt4dLsMPB+ZKbJl3LcmpA8+I0WivTlWSCGHHJQnCFzvrBvQ7dCYZXpxWvNz6exSYJApcjqVnINURwhGRiVQZXR+FJDq8anR4jINmf6+quOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(1076003)(16526019)(4326008)(8936002)(186003)(107886003)(8676002)(26005)(9686003)(52116002)(7696005)(956004)(55016002)(6506007)(66556008)(4744005)(33656002)(316002)(478600001)(66476007)(66946007)(5660300002)(2906002)(83380400001)(86362001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5spLS+M4cQbxMz6+J2HxvfhFamipPSwpdSkWnlx//fWMd9qAQgOiH3Jdfx3j2GUR5uk1v3Vo08arpypfSY0ff8duzZecoOTTb54dww3nbi5DGTL9DJiUOM5E0gsPEm/auQww1XOVDNxz6kEnv7zD3/c/UlJ+NESkZNcF39jw1qOCdmq2DqoyiOSAGDqgt1aXqaSxQ4noFwE8Y1Ckrb+meWiX9hnYXTvZtHCWeKVZh1kk7iBNBDPz0zkg3Xjyg9+moEHpY18MhYhlku/IwPqUNTzJxi7d+KUAQuM0BlXOybqUTSnMlsHd/ckTbXwbhFZOcE+4ftlUs/8LOP3YrzyaIe4OI0U2mC4gB1uKgG64IBIGV+5k83h+ncVGMZKrI+zGZ+BhzPY7kYXb0NunsdfDehw+C/H7R4iJuKZhebbFIdKNE+5Ftfl+f72dDuqkEYUT05Ya60XLXDfijh3ary9EuaZ7B0u1VTqAD7TSH1+g+vqqpn/b1DQXUEGtDE64SqdnD0fl0LVRh8W302gPsdFbBpTKkgbaauX4i7yXWTqxGiIXTxJYgKFXJyic50cq3+OEDIkbk950QZA40ZSnaFVOY14X0aFzawX2RZu94nQX04c8H4sYo9lPiQ0Eo8iYGR64kNvz47spolUs2qurv0nZIA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2d598f-db3e-45ce-e0e8-08d83383eb48
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 05:54:55.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewOh6JRfenvnn9iV3WGdY4mUoeCcI1TKkw3b0Kfr4z47pS90PwxOL/YFBvRx7QqqtQtdwXobCctrQLhPgMTXlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4273
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 02:53:34PM +0800, Jason Wang wrote:
> 
> Just notice Michael's vhost branch can not compile due to this commit:
> 
> commit fee8fe6bd8ccacd27e963b71b4f943be3721779e
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Mon Jul 27 10:51:55 2020 -0400
> 
>     vdpa: make sure set_features in invoked for legacy
> 
> Let's wait for Michael to clarify the correct branch to use then.
>

Michael, are you going to send a path to a git tree that I can rebase my
series on top of it, or maybe you can just take my v3 and apply them on
the right tree? If you do, you can take Jason's patches from the series
he posted here https://lkml.org/lkml/2020/7/1/301 and take my 0003-0010
patches.

Let me know.
