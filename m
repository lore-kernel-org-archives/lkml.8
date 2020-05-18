Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC571C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD67920643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgERTqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:46:10 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:50751 "EHLO
        7.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgERTqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:46:09 -0400
X-Greylist: delayed 8400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 15:46:08 EDT
Received: from player787.ha.ovh.net (unknown [10.108.54.74])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5A770236BC6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:00:13 +0200 (CEST)
Received: from RCM-web9.webmail.mail.ovh.net (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player787.ha.ovh.net (Postfix) with ESMTPSA id 7EA9612A9ADCD;
        Mon, 18 May 2020 15:00:04 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 18 May 2020 17:00:04 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the jc_docs tree with the vfs and
 net-next trees
In-Reply-To: <20200518062253.24709cec@lwn.net>
References: <20200518123013.6e4cb3cc@canb.auug.org.au>
 <20200518062253.24709cec@lwn.net>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <6db686525ee6e1eeda0201efc61d361f@sk2.org>
X-Sender: steve@sk2.org
X-Originating-IP: 82.65.25.201
X-Webmail-UserID: steve@sk2.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11744543403692084613
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepheeftedvhfevuedthedthfektdelleegtdevfeetveefhfekgedttdefgfetgfeunecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/05/2020 14:22, Jonathan Corbet a écrit :
> On Mon, 18 May 2020 12:30:13 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> Today's linux-next merge of the jc_docs tree got a conflict in:
>> 
>>   kernel/sysctl.c
>> 
>> between commit:
>> 
>>   f461d2dcd511 ("sysctl: avoid forward declarations")
>> 
>> from the vfs tree and commit:
>> 
>>   2f4c33063ad7 ("docs: sysctl/kernel: document ngroups_max")
>> 
>> from the jc_docs tree.
> 
> Hmm...that's somewhat messy.  I somehow managed to miss the change to
> kernel/sysctl.c that doesn't have much to do with documentation.  
> Stephen
> (Kitt): I've reverted that change for now.  Could I ask you to resubmit 
> it
> as two different patches?  I'll happily take the actual docs change; 
> the
> sysctl change can be sent to the VFS tree on top of the changes there.

Done, thanks.

> In general we really don't want to mix unrelated changes like this.

Noted, I’ll avoid mixing changes in future.

Regards,

Stephen
