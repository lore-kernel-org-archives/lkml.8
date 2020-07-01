Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DC920747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y0j1KuSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGAGnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:43:33 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:7649
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgGAGnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiIM+qL7A8jfMtHBt1m/9KGrGVZQPenKvell6cI5O6bhmFlAM7pj11OufNzKyv7Oj8FcyXTVAUyHhpthb9Skf9mU2fn049GCDLdSUYe+RpbIeU50fXXCwtvNH1z2GSPnYppemMS5zOeJwnp6g1vB/HnOLCcHam77kAmbtHXie6seMySUobXoIxIkJ9G0KvOkfPk2bX3Fv5rpxdqmto+10CNq7mNdqUfJKVD3L5Po6QS6Ojmg0i0oDPVaciNu84Q2Rx1pJsfuiCWex/DizLIG7AI+U1HP0Vh1iZEKSEY0IrYkM87jAjz7e/+rt8sGaDu4vID4nlv5GofEdLvwigIWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/c5+x7NKO2irCBCb1FoHZNzHDXrC0PrenVKSMv5QT0=;
 b=f1AtIicIftK1XngX0eUU4ABh7O9s+s6Ze2UJduor6fpdvIJPhdO1f4Wx0O70P4IA7y9R2yTogFqA+0EpuNBi3TGRpW1XuebZZSkxztbVcGLAyj5DyfED5EQJxPu1CH4m3fRCBnuPVeE2brCnS+CeeYe03sUEdPNNecu68q5pRLSAaKiGIzLyYVejdUHYPjd9H6BDEQsadElj3dq2bzgPHbPqrti0Sur+/f0osmW+Idxy6DAiBFWbMn6gMomZV2cfu2yYenCTkHskKuf1fp3YqR7FMpVwaioMbR62DLmSg71kTUcPptnpnJm8y77BcE5kxvqbCSZ2YEDEWOQSCOlgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/c5+x7NKO2irCBCb1FoHZNzHDXrC0PrenVKSMv5QT0=;
 b=Y0j1KuSzGIu443ui6XV1OWQaFDyNI4cAe9MAEGEopG5X0uoH5PuxkXFtl3mlArVbCaXQZ1u81frfXJc5aKSTg3JmheMyUQe0EojMo6ln2H0nUlTaxpACVRDzL3Tj2KuZ4S+fRo3aupoXQ8zESMjnxsYX3i3FuryASi0pASO2Y44=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3784.namprd12.prod.outlook.com (2603:10b6:610:21::28)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 1 Jul
 2020 06:43:28 +0000
Received: from CH2PR12MB3784.namprd12.prod.outlook.com
 ([fe80::bc87:1290:7ccf:ac8a]) by CH2PR12MB3784.namprd12.prod.outlook.com
 ([fe80::bc87:1290:7ccf:ac8a%3]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 06:43:28 +0000
Subject: Re: UART/TTY console deadlock
To:     Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain> <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
From:   "S, Shirish" <sshankar@amd.com>
Message-ID: <3b665cbd-7afb-b72d-22c0-7dc1543ac42e@amd.com>
Date:   Wed, 1 Jul 2020 12:14:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200630180255.GD37466@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::18) To CH2PR12MB3784.namprd12.prod.outlook.com
 (2603:10b6:610:21::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.85.182] (165.204.159.242) by BM1PR01CA0124.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 06:43:23 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34440ad8-f26b-42b5-d426-08d81d8a0fe3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4183C98CEE04FEB45780DD7DF26C0@CH2PR12MB4183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+Nj3N29GMJrhQg/LLd8j4593p+klDrBfJHemqGGL52eM/z+KeHn8gTsda+y6I9v1Jb4i7/idX1tsp2DoF1Dc6W+c0ldPEA89KkK4ZQLftt+QReM9JmLh0+rMjek7TblvK8r4N8xrm0Jb5CYoyJe67e+KGqiwUnVFSvBtKRmQmjmyCgUp7bq1Q1ZQzyDh6p3x2+GCnDssdN9GjdYpbCD7gfmM01I4mQ+PHQJ5dXORz8IpK/YOEbffhsIKvtFPkKmUjt+n71qtEF2lqW91M/ngqQVrLM6gMupU6w4uA6FtR4VA+nv5JzzFWZRmpTfyGvaD0lJq3sU2zor9YGC1d6slW9SiSB0iM4Cif26n928Is/BxGnITFAnBXmBVZ/Sdv2CxsaiNEp4Ak76vamlfbRZbZMFM+jfYBaHWib1mdRdswY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(31686004)(2906002)(2616005)(26005)(36756003)(54906003)(8676002)(316002)(186003)(31696002)(110136005)(5660300002)(478600001)(7416002)(4326008)(16576012)(6666004)(3480700007)(66476007)(8936002)(956004)(52116002)(66556008)(83380400001)(66946007)(16526019)(6486002)(53546011)(326664003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZI3pmO4HJ/344BMnDlLVw1VaCXplF23sKEo7gEjlth6jf38/PcNReL5sC0Al9D5umC/mSlKmCPL7++jTMkLV1PK3/CTfP2BOYkdnZaG552DSIjY23r290wy/GA3mqJKYvptD6uxwEDLIoRHoW/d4YZhsd8JJmZVaEW5ZrdbD5M00df39KAngRbwL+GPalGlGNLq3u01bU19+A03bXRHbNitemAUF+tzSmMUpOHXeY34/xGllWu9ifeRQZ1vokbRPLlZJptP8CBWUIlPnHU7AWyh3Q+aZ9CIt2BNFDfHRMgOPmQgLOT8+rgQeuH8df5zEkHDzEwd1WY3WKSXJoKn3+9qD89614cYtwu5760oRlVEt6L2oUOq5lvj8L11Ogdbg/QZd0WwnVvLoERotNLEoOXhBiO/EVnx/JckggsTD/HclnqTAYwyp04U5uSB/mwIdarrFFov2TLyAJN8ueK1WPRQDbvP5dsphymx4hB2OtFK1K9f9n2dxIeSo7bXStW+b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34440ad8-f26b-42b5-d426-08d81d8a0fe3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:43:28.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Pbpj0CWNap+CNhvd0alFcRB/uJhCiWV9OjPiR//OYm7qZAkNNu3Koo7AnQYEYMZ/RVtr31p7o8Xf7liU4fXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/30/2020 11:32 PM, Tony Lindgren wrote:
> * Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [200630 13:06]:
>> On (20/06/30 14:22), Petr Mladek wrote:
> ...
>
>>>>>> @@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
>>>>>>   		 * allow register changes to become visible.
>>>>>>   		 */
>>>>>>   		spin_lock_irqsave(&port->lock, flags);
>>>>>> -		if (up->port.irqflags & IRQF_SHARED)
>>>>>> -			disable_irq_nosync(port->irq);
>>>>>>   
>>>>>>   		wait_for_xmitr(up, UART_LSR_THRE);
>>>>>>   		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
>>>>>> @@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
>>>>>>   		iir = serial_port_in(port, UART_IIR);
>>>>>>   		serial_port_out(port, UART_IER, 0);
>>>>>>   
>>>>>> -		if (port->irqflags & IRQF_SHARED)
>>>>>> -			enable_irq(port->irq);
>>>>>>   		spin_unlock_irqrestore(&port->lock, flags);
>>>>>> +		if (irq_shared)
>>>>>> +			enable_irq(port->irq);
>>>>>>   
>>>>>>   		/*
>>>>>>   		 * If the interrupt is not reasserted, or we otherwise
>>>>> I think that it might be safe but I am not 100% sure, sigh.
>>>> Yeah, I'm not 100%, but I'd give it a try.
>>> I do not feel brave enough to ack it today. But I am all for trying it
>>> if anyone more familiar with the code is fine with it.
>> I see. Well, I suppose we need Ack-s from tty/serial/8250 maintainers.
>> I would not be very happy if _only_ printk people Ack the patch.

FWIW, the lockdep trace is not seen anymore with the patch applied.

Regards,

Shirish S

> This conditional disable for irq_shared does not look nice to me
> from the other device point of view :)
>
> Would it be possible to just set up te dummy interrupt handler
> for the startup, then change it back afterwards? See for example
> omap8250_no_handle_irq().
>
> The other device for irq_shared should be capable of dealing
> with spurious interrupts if it's shared.
>
> Regards,
>
> Tony

-- 
Regards,
Shirish S

