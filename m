Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD06EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8233E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KFgBTeJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbgFYHsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:48:09 -0400
Received: from mail-eopbgr150093.outbound.protection.outlook.com ([40.107.15.93]:65409
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390237AbgFYHsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBU7zUOtwywAtvpCa7ffITy/z+Ke7KJbMnQ7ABaDo1XYPMQKLquWwjf/syOQ/VwOpg3rVTODrp5t+lNxiMEL0FBljr9hUHGp1XG3zUuwNRpchF82xApLVA5LGpFsUem4r+LVIfxHzmQqCFkJ/76SbgVRgKs0ysIsHTL01DzQ6nSNeSwKeA8xTN1NzA19fefhJFNizMcO2pMCS0jWHd4MsFjw8/JSgtyRZr+NQGbVoYUbgbxHBlrMyTi6ANtVtwW33ymACBelkqivjM2/lEnRNXJK5GHDEOUCCiVD7APDH6I2wmZwwimab0MZakgA1uMZB611Q5jH9z70rc8I6GzxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEjh4fsZAO90msZT/yPhwedD/ebhw0OamtfjXlTwwqw=;
 b=PlggzSmRUuhZ+6inTZuSAhKuLBk7/ApcLG3wO2q7g9zYQL+V99IZHy9deebj/u/2jfzR4fflIMFuqjDzwVrnGxqpt6PAXBA3mxeQ3c/YyKfmEY7Dl2EV5ovIVHHnid4Uv3VcZ9I8VXfwMw2H0sJA0AMI8P0y08B/e79zrwpc/96vZaiar38nau4CxFijO6rWXzg+6USpvCAyJGF45DUFgOkFHFj4+OY4sW48j2lhK44MDUZNNkqBINTGkPCtE9mmY24itQO1QWDPBuvQRHTnvqaKt4SOIvlXAsasHbkuHEHchE+rfI1fNLP1543PSxk18tcmLYxu2AA6kH5RWd8sNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEjh4fsZAO90msZT/yPhwedD/ebhw0OamtfjXlTwwqw=;
 b=KFgBTeJ9Rccu7PJkFvg8NrxeLzfMw3uxMWd8oG2KvVXfRAyCWCTwLk53lf9704AVL2W7/XPuk0jdMHOy44bCFXPrzwgCk6HAPvI0KMHg2lyoibvwMyNrJwtepNIg+4T5K/s3zcDevQJeZroSc97V/6wex9oYM4Ez9uvdpwMLkjg=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB5425.eurprd08.prod.outlook.com (2603:10a6:208:17d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 07:48:05 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3131.023; Thu, 25 Jun 2020
 07:48:05 +0000
Subject: Re: [fuse] 6b2fb79963: WARNING:at_fs/fuse/file.c:#tree_insert[fuse]
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Maxim Patlasov <maximvp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <20200615005036.GU12456@shao2-debian>
 <ea00a67e-5a61-2e70-215e-004e3dcc57c1@virtuozzo.com>
 <CAOssrKdTTZEBEfwFm+3dYJ5XB9FsFAeF5g5ydeSo7ZPKkqjJXQ@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
Date:   Thu, 25 Jun 2020 10:48:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAOssrKdTTZEBEfwFm+3dYJ5XB9FsFAeF5g5ydeSo7ZPKkqjJXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:208::33)
 To AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:208::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 07:48:04 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3ab9d98-b7ec-4ed4-8cab-08d818dc1849
X-MS-TrafficTypeDiagnostic: AM0PR08MB5425:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5425D501F0BFA83604774D94AA920@AM0PR08MB5425.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OunO23QN65ERKsmyu77SRVRUyxj75YBmcrruGdze1PlgA5R5742QMu0oHulRrGHo0AYZo65pSHpmAJByfglLHAZPjCyVJqjQSisSOt5O7aVJs85jcUycEwoUPxPsAr9ffgC1pK/8WhNb85JbwTieyN50swPRIqCNLmxIXhtZ+6yAv4dtRpOjBXEhNPC0TjIQan5+O63nuKAD2C+Z3sL4fsBJcnnnGnDotn/CZwo476Cpr5FHIQABQv4tdbkbfM4MF4sYTNemUBvpsQknCc6iJmrQZiJKyrE2sVY6rCJaVcmOzkQCMrMaixuaW+IQI0L4/oQjuzw2OpBrUnznLnylm7/10/QwAJiM+YVX5qORMX8TFxYIh+uqpNqhRzSiRwtU9HFmseSQ9zR+FWjHbXnoExDVMKJOuMvjgyi6MA+fwH0IrHhd4ozkNFcAV9GJ43X5IOz3X7sTry9COzBP+o8eNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39840400004)(346002)(376002)(136003)(366004)(316002)(83380400001)(54906003)(66556008)(16576012)(66946007)(6916009)(66476007)(52116002)(16526019)(31686004)(186003)(2616005)(956004)(6486002)(53546011)(36756003)(107886003)(86362001)(8676002)(2906002)(4326008)(26005)(5660300002)(31696002)(478600001)(966005)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: K+jPF2FURv18QRj0SNEx8FW6Oue17rP/gLedEitahpiTVToZAqsICKhx7+H8lMuQFh09XGaxygzaJ3IRyYUbKjZvmR2RPdy4qA0LkWU3kPk55Q0kuFL2JGWAaMytrzA2wjFn0Pqv9E4RZQQMyKEQ/PjpkBcwOosFwVkN4JCHJjzwkkM4xH3zSdig4c1AJpHXShm2qAsRehjpBwiBFbR2TQeeukoWVoykTSSK8ROfhq+XtsdJI7BfK6iIVq/xvvTf9PWIdpSE/uJdLDJZQqRe9XHFGC4g7tfi3y4/tPWSV0lRpwe++c7tqFgSf3QbIJcNaGpf8nZhQuN9gRR6I0Nwby0Io3C5Uo1lWhg8G4CZvu3/4e3Fv/J1opDOR2yasnugn0B7SCaoP8Da0pry3S38ciFzOekl03Myy0j9Lq82W6mq2rDw/tiQHma6m7b6ZzIcCwFvxwf16Ow6UyHdCLUFsPUtaUFAgJg96IJHPz9inyc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ab9d98-b7ec-4ed4-8cab-08d818dc1849
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5140.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 07:48:05.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxWihUArigU8PkZX7erxRg1WFbB0SIgr96BsDtEMtpaNSkvS5zv7HDmSvfZvRN82MK80rF4DVoi/YIC8T6CPnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5425
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/20 3:35 PM, Miklos Szeredi wrote:
> On Mon, Jun 15, 2020 at 7:59 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> On 6/15/20 3:50 AM, kernel test robot wrote:
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: 6b2fb79963fbed7db3ef850926d913518fd5c62f ("fuse: optimize writepages search")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>> [ 1030.995703] ------------[ cut here ]------------
>>> [ 1030.997563] WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
>>> [ 1031.021943] RIP: 0010:tree_insert+0xab/0xc0 [fuse]
>>> [ 1031.057802] Call Trace:
>>> [ 1031.060015]  fuse_writepages_fill+0x5da/0x6a0 [fuse]
>>> [ 1031.062536]  write_cache_pages+0x171/0x470
>>> [ 1031.064933]  ? fuse_writepages+0x100/0x100 [fuse]
>>> [ 1031.067419]  ? terminate_walk+0xd3/0xf0
>>> [ 1031.069707]  ? _cond_resched+0x19/0x30
>>> [ 1031.072140]  ? __kmalloc+0x274/0x280
>>> [ 1031.074407]  fuse_writepages+0x8a/0x100 [fuse]
>>> [ 1031.076599]  do_writepages+0x43/0xe0
>>
>> It is  WARN_ON(!wpa->ia.ap.num_pages);
>> however tree_insert() was called from fuse_writepages_fill() with ap->num_pages = 0;
>> In submitted PATCH RFC we have used
>>
>> +static int tree_insert(struct rb_root *root, struct fuse_req *ins_req)
>> ...
>> +       pgoff_t idx_to   = idx_from + (ins_req->num_pages ?
>> +                               ins_req->num_pages - 1 : 0);
>>
>> Though committed patch version have
>>
>> +static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
>> ...
>> +       pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
>> ...
>> +       WARN_ON(!wpa->ia.ap.num_pages);
>>
>> Miklos,
>> do you have any objections if I return to our initial proposal?
>> Am I missed something and it is not allowed now?
> 
> No objections, but you need to explain with a comment why that special
> casing of num_pages == 0 is needed.  I don't understand it yet.

fuse_writepages_fill() handles few different cases,
in some of them data->wpa should be re-allocated and re-initialized,
another cases requires just add new page into existing wpa and increments num_pages.

In current implementation fuse_writepages_fill() tries to share the code,
by this way for new wpa it calls tree_insert() with num_pages = 0 
then switches to common code used non-modified num_pages and increments it at the very end.

I've prepared patch that calls tree_insert() with num_pages = 1,
It have few other minor optimizations therefore I think it is better
than remove incorrect WARN_ON from tree_insert proposed earlier.

During investigations I've noticed few other stranges in neighborhood:
1) fuse_writepages() ignores some errors taken from fuse_writepages_fill()
I believe it is a bug: if .writepages is called with WB_SYNC_ALL 
it should either guarantee that all data was successfully saved or return error.

2) fuse_writepages_fill uses following construction:
if (wpa && ap->num_pages &&
    (A || B || C)) {
	action;
} else if (wpa && ap->num_pages == data->max_pages) {
	if (D) {
		the same action;
	}
}

- ap->num_pages check is always true and can be removed
- "if" and "else if" calls the same action and can be merged.

I'm going to sent separate patches to resolve it.

Thank you,
	Vasily Averin
