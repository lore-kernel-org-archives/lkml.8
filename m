Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CF62074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Z+1WmXpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgFAMBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:01:15 -0400
Received: from mout.web.de ([212.227.15.3]:34827 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbgFAMBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591012849;
        bh=4P9phAQrmp3CfuNQy4CzvA97WVA/AJly2WoCFPFsn7Q=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Z+1WmXpdDPE20i9iV0SQGzopuEoWCFvYKOB82PG6H7V9DhhYmL4l9KqZ3A8OUfplw
         aEaJVrGtHeYuA4pumgv/X4/1i6rWdNyuxtBW0a0N/FtEUhXGjy6/0iYQXyB+SOlu8c
         tzSbBAp3JkOgyJPxnPx9cqXrT2x1VkHPJ5jCW4Gk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkhUq-1j5HqH24AO-00aVVF; Mon, 01
 Jun 2020 14:00:49 +0200
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Yi Zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH 1/2] ubifs: Fix potential memory leaks while iterating
 entries
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2bec05b7-78d3-fa36-134a-efbe977933e3@web.de>
Date:   Mon, 1 Jun 2020 14:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IdpEoYDvQsuZM/z5K/PT5aNV6CLdkHGds5NdmMmoNSqRhgO7mKo
 Yez3oKJzi5xpMdj6007Tx3ykOi8B3QZrBryvzIKnwnqIFXYaqkaduU0WmRj55QVyanBVfQ2
 ZR0XVLhzWPSoZ4RoBNecPAuAN25K3mlKOYhDD/L6/7Bk+drZED/SCwzyA70zOGk2HVUfdiW
 oHOjKbvSXZ6AlafmEnUkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RBsBHSN+pz0=:oDzhTP+wNVUdtrNGQuiIxV
 u58mTQGk6XdFcclvzo7Wu3/VjSZJukZWrSfX7IhKBIHzhJJww2a7SZtDPB8o4O8WS4XiC4q9F
 QM83eEuV6BR8SFZ3NNZJ5BWgO2PiWLBAIngDQr9qdtHm0qwEyQyAza07TbC3G49z8da8hhUz6
 JJoDHIGKhqRj/FxZkXWwwMNaycLGKKfoby28wY8SGzJ+eKbWSdZBtoi6BN1xCCsasME6LLc/z
 Sna5eutgBEoUodOV8JDdqge9H6wYbJ2say2WtVnSKYItUh9WZMljkXN4ZmZDSACdiEpXXu6bi
 xJZPL60ZLRBHq1P3cDP2r1fd0Q/GMq2usyGcsOF7bZyXSos+qZ0L+NqCVtQv8XuTRmqtwUE4S
 MRXlIz9OTkVcuPj2lMZjUlxmUTR9+rV1pkUQxK8VefRXuP5I5lehEFmYB21lXrBStpmxROghg
 C5QiSEtSZEW7YJ50nhKbxfi8Zsr1Pv/mcKQHc3X8pdNmWtHe2DYanTe3OAOjDMie1rXFc1Akm
 XWYyXRvEi2Poa/Pj1nage8/xEtfa/C+glamte9wkOm/nxH4JBXHZUmjB5Yo2iaw6zjLEAA0QH
 UFhHD2h/tM/NG/UPucp6+KxALxbpJaioys/lAPz8PjrE5aKDqQBh+y0/tbG3N3MAehHvH5EOt
 wXVNJnuqFvADYY/kqAE046eGT5yXs1/Cc7t0Cxph7syWTPQSDD64JavQiueYpWi6cMM+3qV8K
 Ep3pZj7y9eK9MAfL2yFzou9UF1MjbhjwPkfm837GRd9OjD6+4+GFnQp2Ztrvx6iqbAtiXZZJ2
 WFaTvMwKLWAG4vs3pGhvJqUzCXG5zuFXChv/lrLT3YneU8TjLf2PvIkrRFCBOZZSjZgri3uxe
 ctGMTiWtwB8xJCQldbdxECayz7UXfEyOA/LJI9aVj2eVRif9CS9XJWPN/xGQNxEqOpMROFPoP
 nRpkZvD8JDkKOWfYipA/icO7PCEf7fnT5iZ6rTGzIPW2W7qtH5h0TOXpAxHG5pSWj1GDpHmim
 bk5rX512Dn3ANEfTpbfnDTHc3yI2SbcSbtntt9xWuycxb9hnijIjKMXFYWRPfhahyqp0DEWQ4
 a4WmYQhdiiE/G1mRGAfkbtzr4RRcUUVPuopDh+pqdYhXLvRWzJPpyVBdud4Bdmx6wvdYpEDAs
 Uh4yxhSLLskYNpV/2QO+F4djLdmv3wbFlu4GyXQybv0WFnhbh8IW7EQBdZO7pYxZsL9EBPA0a
 0WLXibkIv1ADtLLrb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix some potential memory leaks in error handling branches while
> iterating xattr entries.

Such information is useful.


> For example, function ubifs_tnc_remove_ino()
> forgets to free pxent if it exists. Similar problems also exist in
> ubifs_purge_xattrs(), ubifs_add_orphan() and ubifs_jnl_write_inode().

Can an other wording variant be a bit nicer?


I suggest to avoid the specification of duplicate function calls
(also for the desired exception handling).
Will it be helpful to add a few jump targets?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162#n455

Regards,
Markus
