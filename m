Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B765C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DAF206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTnOGZwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgFDWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:23:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34007 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgFDWXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591309413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eACp/oLaKXsSvlY5Fq9o05NcQuVVZ80m7RkJvy6ZwkE=;
        b=cTnOGZwusH8Nhq440eP0X/DVjUYWLv5/14ySCEDZDpYaPk3RBbxddDuzLHE11vs3Ynohd/
        P9UHKc5oWXU5KYrjKhtc7pMEw0MaeXHD0pEa8noSW0vcv9TWP3emY+of/9Y4/4c30+TNQu
        UVSFqa/PWVo9wQInwGIYQzf7tRrWluo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-yg5V7Y4FNu-w6SlF4XzR-w-1; Thu, 04 Jun 2020 18:23:31 -0400
X-MC-Unique: yg5V7Y4FNu-w6SlF4XzR-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EF74107ACCA;
        Thu,  4 Jun 2020 22:23:30 +0000 (UTC)
Received: from localhost (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38D3010013D7;
        Thu,  4 Jun 2020 22:23:28 +0000 (UTC)
Date:   Fri, 5 Jun 2020 00:23:23 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [netfilter] e32a4dc651:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <20200605002323.501b1cc6@redhat.com>
In-Reply-To: <20200603084934.GF12456@shao2-debian>
References: <20200603084934.GF12456@shao2-debian>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Jun 2020 16:49:34 +0800
kernel test robot <lkp@intel.com> wrote:

> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: e32a4dc6512ce3c1a1920531246e7037896e510a ("netfilter: nf_tables: make sets built-in")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: kernel-selftests
> with following parameters:
> 
> 	group: kselftests-netfilter

I couldn't find this information in the report. Would it be possible to
have here an indication of what kselftest specifically is failing?
There are a number of tests in that group. I have an obvious suspicion
here (nft_concat_range.sh), but it would be nice to know, in general.

> [...]
>
> [  165.316525] BUG: using smp_processor_id() in preemptible [00000000] code: nft/6247
> [  165.319547] caller is nft_pipapo_insert+0x464/0x610 [nf_tables]

I'll take care of this, thanks Florian for forwarding.

-- 
Stefano

