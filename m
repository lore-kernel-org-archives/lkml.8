Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A3AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C8320B80
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="C+ULfEof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgF1LSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 07:18:25 -0400
Received: from mout.web.de ([212.227.17.12]:45943 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgF1LSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 07:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593343088;
        bh=XIR7Cag6HTDIlHHI6CyQMvf0xsm67BGOeIQf5XM3pxk=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=C+ULfEofEvEz/W7wRNGhuLZyc1OttYTllZVyuNxRyn0hCXGLmatm5IijjLVXwzCrZ
         naZurDbTq/pmgc+2RCze9po93xcfvSNGSe2kNdeSfUDA17ci/eY3mYMyIlT1Ky0/Fv
         osnO7mxlkS5SqJjqe4j/szwI/cx3T9ibbG5O0tvg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.52.166]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRUFI-1jMnHs0mJE-00SdZP; Sun, 28
 Jun 2020 13:18:08 +0200
To:     Long Li <lonuxli.64@gmail.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] mm: Free unused pages in kmalloc_order()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c5f54ce3-dad6-a2aa-d32a-cc7620676b76@web.de>
Date:   Sun, 28 Jun 2020 13:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xl4o3r1WzSe7g2Lknm/r9EPJYtCQzfDOhmFhsvKnvN3l+03nylC
 ttIgRHINvJWBK7QLtWhR9ZK7uzJMzKcrdsVe8WvqutCQlAvkpK5O2HJV5X+Ha6iMIdlifl3
 s2YBGVkXebCU0Z7J224nqWKjR+XIaaJcQCF9/os3W4ujippAX6MNJfRrVdsshS45hqVRRi5
 OoE5DTRZHUWyoRJiI8Ljg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pbgjgpo9Epk=:R7ZdCbJCNv+nknFNfI7trm
 EZbyO3MNwmNw1UqH58SeE+tdfyAdq/ThjnfhuoLCo/tOVW9uU8JfG6aGYNaXf4PD8VvdbXxe6
 9aKCKvmnrGfbj/q/JRrJpOob5j7Voh2D6Si8OcxSQKwqcK2MZXzDdhsDbZwLdiZj0zoNalxF3
 RhpNQ6DufesTOrFL3dWJIoVAm6PQiAtHCwJbbk6B8rNTot6NeyZDufoX52R2JuH5ZwH0syR77
 JmG7P9UXmIGg35DuHwHmwAZhgmFTFqIPLI7rbIuxmPynXbEolHAnRKPnZb6pYTHOu2F05tKD3
 S/jlY9JmFtkjdFtjJzCMT8ZvHe8mYHLGLBIfGWlxAWanAVhfaa/d2/WZF5+lSRVXBPzPlsGZm
 67s3RG6N4u21QR3JpE9FRrjIki4wAjOPa7R89vpHR1Q+wmDVRwVxmKN8qdix5/ujzzumUU2wg
 YVxWSidMwZgFi5FEU65jy4k8FDaQHuvBwrMd87FSO0YuRxSvqpQ3RAC6it2gF+YEukWYrKOfK
 CKgVVbt0g/fMo9G4882qnkr8QxyQPJd5WBXKCN6Bkgig2yCrUbNnqJaXIph0+fhHkF/t86pAc
 dZWEIkEx+AkSaO8hcc6UQ20ihzSXXFNQ5y0wuaqr1REjusif+2rcO6uaLpWULzJ1UwjpfN2Tt
 eNkKSlHazID6g2ZEwIJ7XDdJqdE4/lJCmL43qAWyMHvi94Ac0Csbwi4wbzHpdYijrecYpy7FT
 6N5+NRrXMfO51O1lr9LUXoFlfS/Z3r3k+2iTM4FcsKORdMTe7iRrAW44R0FT2dyAr07SVzjtS
 Px04xDlL/IRxeDibGmOcf6dUbi4iOuuq7K4wc+h81QipkmR7kRiu4U0TlHT5v36fCN7FMwJsb
 38OXitiund55QWdkKP3W8YyQHQQrOgX5kcVhJZpPKCzaVZPLb9U51xUJ7GjvbIMH+o2d90yzs
 SOcqTzhTzrCgltxgOizosThbTahHxEPBSmNGNrXYsIGXq4881AKuFSeJA9T8axTmT4Irh8y9k
 0kD3ETsD9ZTojpN0Ko4/GC5HkrHv0UxTUYCJ1fNGPMUVI6x3FXcItSczP626RER14xmlyV/i/
 V2lnqxj1BMAsNo2qMrSUthcxS/pwDwWu1OoiNEErtiCJQOQqLksAt0tZfRdA3NT/KR+PNfod0
 ZiGjrhcoZxh/w1a18lM9m3JwckfX8MZVw0ba3wQfPPFWlC86MvksvALPOVXgjMVpQokT07zPo
 mkBksaZr+mF8v8WIk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> kmalloc(1024, GFP_HIGHUSER) can allocate memory normally,
> kmalloc(64*1024, GFP_HIGHUSER) will cause a memory leak,

Would you like to explain the influence of the selected allocation size
in a different way?


> because alloc_pages returns highmem physical pages, but it cannot be dir=
ectly
> converted into a virtual address and return NULL, the pages has not
> been released. Usually driver developers will not use the
> GFP_HIGHUSER flag to allocate memory in kmalloc, but I think this
> memory leak is not perfect, it is best to be fixed.

I suggest to improve this change description.

* Did you apply any special analysis tools?

* How do you think about to split the text into more sentences?

* Would you like to extend any software documentation?


> This is the first time I have posted a patch,

I find this information irrelevant for the proposed commit message.


> there may be something wrong.

There are usual risks to consider also for such software development.

Will it become helpful to add the tag =E2=80=9CFixes=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D719fdd32921fb7e3208db8832d=
32ae1c2d68900f#n183

Regards,
Markus
