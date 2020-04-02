Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316F7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D162077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="cOsDgqvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbgDBXmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:42:40 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com ([40.107.22.106]:10898
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390172AbgDBXmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfTE1OtBP9ZZgc04EfVc/Sr1cu3MESCBaG49igJTniuzG0fX+XO4aiNnJRJkMlwIzQobNI3ocMp0s+oFt67m2EwbawGFy+l44FeT0Ro560gOqgIXMnGsbS76d0V8nIpAUGdMWbI/zZl5SbIlti4SDI+/7eGXtAf7fwImRWkC+qF/eqB65/uAjDaNluElp9TuEKzOsMW+iQxVC5oAlBVsdWWryR/y6yt/CKC32RDkGGAPTjw7R2Sdoj6FkiHbuQNmnMhz7PylZXmQDPXlphhFkqDkXD7AXOSnFkfyDq63yvx9FsQyH7H4SP8frIrn1cPJz1gOcD2inCFXBEMjlL2vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKj3WUqrcwvp2QT+vyIUFxGcn7Uo02+PrLQqNtMvNdM=;
 b=UlvMFQU2EQM5i/53sszfQNLAeNUzez4rj5aB9lawoVu+JUfFRUFf3C3dtnTRSpp+xCupFxlSYmJ3Kxlvu+BuBawoqtQBM486DctyZSdbyU4txd9KwPxB2mHm8hn0zRmvEW4Ola7+pmbdd8UhLk0ovENetqv/Hae+el6olrOsjTr0IHvDy3pUTkXoEDzx3PN871nww/bC7D2NdlhC0Z+yoKbnxUkC+RvVf6ZRNZJDq0IBlRpqrWxLXx5cI74K9Aif6DT0siSi6OIqxznb3gRI8Gn52FQmfuaYj5Q6FjLxL35VRM4vy5Lvs8fyGtLVZ3AF0ETvyenPAsWFSFHF7vJG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKj3WUqrcwvp2QT+vyIUFxGcn7Uo02+PrLQqNtMvNdM=;
 b=cOsDgqvr+1ZHGhbelw+iAbI7h+Q8a79MjsRr4TZgYobbv3Gtw0Q6CzU3wp0k4pGX8IU0Euu7AsjBM9ujHmagEilx9gMCFZTSVAngKv3+OmBYg/ofxn9zYKrv57G5Qw8rvZoVB8DHgwtXfTugYC5zo4s/VC0yPtPHUaSK923JYzU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rasmus.villemoes@prevas.dk; 
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
 VI1PR10MB2190.EURPRD10.PROD.OUTLOOK.COM (20.177.58.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 23:42:36 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e58f:1097:b71d:32c7]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e58f:1097:b71d:32c7%5]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 23:42:36 +0000
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Kenneth R. Crudup" <kenny@panix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
Date:   Fri, 3 Apr 2020 01:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200402124205.242674296@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::28)
 To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by BEXP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 23:42:35 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd49d0d2-fabc-456c-d83e-08d7d75f8588
X-MS-TrafficTypeDiagnostic: VI1PR10MB2190:
X-Microsoft-Antispam-PRVS: <VI1PR10MB219030243F05357D9A19102293C60@VI1PR10MB2190.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39850400004)(396003)(366004)(376002)(346002)(136003)(956004)(86362001)(31696002)(478600001)(52116002)(7416002)(2906002)(36756003)(81156014)(81166006)(8676002)(5660300002)(66476007)(16576012)(110136005)(66946007)(6486002)(44832011)(16526019)(8936002)(186003)(26005)(2616005)(316002)(31686004)(4326008)(4744005)(66556008)(54906003)(8976002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: prevas.dk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGtK0nx0MvdNLXvG9qcdRsLAOKcL+AlUhLLLZj8BHHtWgLzYr+bFZj2MYxRfce9AnrWEEx/r80hLL0RWRVtbIHsbgjIc8BJb0JOsncRCKh4gWjwO49KVR/O5G/qBQZsVFCnhYN4f4YXevAUVq5FvdZKFJAI+deqosmQ2n5lGyM9CXvfewyI5SeH6bfVDz4WHIJuSLNa32FM8fPDjRiMGIR7ToWxfvlGnV0BI8LfYDcVbqYWYZ6eHe2kouuv7lqsvnwUlwxxhrjsa071m/6rNhIsvkjrFiYJrQPOmBXlxw5XQlh/tyXfPTJXtqAafRIfBnX+zIDMylgd+URejUl7XHP0d3jSU8KsxwVXsi8VmYfYH/fT4eIMmscEoCWYyMJ2b7DZb+0SyEvtUcQq5Y3jQ31Xuuo2oZPfHa0L403jT4E4YFeIH3VR8nMCZpRLp5oDw
X-MS-Exchange-AntiSpam-MessageData: 735FzlMSS16ciuaISdaVRsVKFkhJGouUMLaJa98fh2R0In3R/JjBd8zolnP17qM5d22PCIa5BVPQeywgzcL+lZPRhtG5J3inKRkj/lPe2lKF24iAcqF64JdvsAlGQQiaRVyTWk018rRspGmqp8M95g==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cd49d0d2-fabc-456c-d83e-08d7d75f8588
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 23:42:36.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsjcpAUCOLCkTE7AX6mAvkhluE58rfNoTp9DRjTueoS2UFqDmtlu1KMDOqpRzDC2QpC3Lri8ia42l1q1cnNehmR3ItdiJe7q+PUACdbKoIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2020 14.32, Thomas Gleixner wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> It turns out that with Split-Lock-Detect enabled (default) any VMX
> hypervisor needs at least a little modification in order to not blindly
> inject the #AC into the guest without the guest being ready for it.
> 
> Since there is no telling which module implements a hypervisor, scan the
> module text and look for the VMLAUNCH instruction. If found, the module is
> assumed to be a hypervisor of some sort and SLD is disabled.

How long does that scan take/add to module load time? Would it make
sense to exempt in-tree modules?

Rasmus
