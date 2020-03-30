Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE5BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE788206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="BDgnOAJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgC3Ci5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:38:57 -0400
Received: from sonic313-10.consmr.mail.ne1.yahoo.com ([66.163.185.33]:40093
        "EHLO sonic313-10.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728687AbgC3Ci5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1585535936; bh=VD70aeVEGZzqHFz6t1O4xsHegNnmsjzLe99VqM0PnYI=; h=Date:From:To:Cc:Subject:References:From:Subject; b=BDgnOAJJyyQN7W8Xtn6o2PGR2Cg3SdTScuhUnYY0WCmRW34yj8rNvJHL5GuA0hBXjJPkq97yaHmaUX6wEp1kthAKjJAST/QwiRXDFnSKrKaFscScaJZbS38utwyLC7+Km/ywHT3vnsAehFOYNvoo7tMuIYBNatN/k3/4Ly2sKLEGgIOrdUXI2OO6DdBbSKg6/D69B9vqbtfpyNxQj27u/MwYkdQLCVZtZEaQagiNWruA6TCG2gT4s0AEEE0pAGoODAH53zxje0JDJnY41payd04igsNHDEDzsLZHTfvqGY4XyerVzLJFIpGaiF+jzb7yJVqDCke3ZWUJaYzhIY5uIQ==
X-YMail-OSG: xTFBxcYVM1mbjayfIp4dm6zffI88jjoYlXxO_oLCjEPmgAYfjgh93gq6FdR9Ay7
 3a1vldahmOpihGMhB8iQmnQxwf6Jws5Y9MFDvLizxjTEyIt.DhZlzJr03LG_Aqdt.bY9LB_rGRYy
 kT30W.CMgKtgs8mspVPTunTTIc8YEuIqTQ3QfWH3gdU093vWrlGIK26lkNX65eebwcycAJAs4Eu_
 CLwC6gVLcqYP0YhjeBzsR.XCGnb6JsEUTQTzxc4g8yCCjohSz0U0fVh7jVmJN7C4EaTy7uiI3yJs
 w8wHOd7cG94bd1J2mif1fv6zRcmbf0E2CYHKACjNSf7KdrtVlQ41s90ynMHohzkQ4_qMx6Xngc5p
 HeqfwSuFvqIbA6.HZaYX4HIjVY1qEQCE3gbiv6AvMFgkfVLy.0kUsc_scv6oYnsBEl.vKnuTBwlB
 20dboLrgGRjLcNOe1FYEtXAbjxaeFtuERhs6zn2wiiAq8wzU1Dh15Wslv9UDNKGpR7z9vQCBRmJD
 TVpZ3EqOjdHyT..t8_y8782G7C18ykbxUH0FLfy1Q0.Vhq7c_RSsyU_mDPEceXePTmJ0iBfjojsu
 6wl9EPHbcHUENqzGeK0y6xm13gAtR92GQ.C1h9NJdZyqjajHrkH0Odb0MnLuVnEBX8bhl0z7uanY
 b.F.Xx4BtyxeK9n6LUqWIIJxJnlJ28SLsI.OoJD9765zGse8ClzA5vV9BJd5FXguQwPrjipzhdKo
 tzZnQzfydLdnr5JcZCtN.j8L_5wzaKMmmGNFbYWO0vvuNfaS6.7Os9SqWwWUw3fUHx3sHhdgGno2
 TQRtMzDxdWQSI5g4vD3kzBHmMzA5mQZ3fgueZmMczw3g.OP8WtVvoeMWDVYUpDJz7a0zJSJmqpRi
 QDTlZsh0KbaJ7ez.YN3nKTlC7tiLLKOYMnzRgopw.ljvXQuGcYDh02xbbIBp.7mJUSV.mGYmxWEQ
 4.9CH45rieqwHfoFOItsMGRUe4QYhmycbzG8Y4AZv0hFv_elUTcdgPrsbenZ1_FFjJJhafpeWF7J
 I2RKxiMqg5GQ9Hr.Ifpd1NoFXAv13JxP1GJVHh5Z0VHclcPBmg6VJBrjhE6WlsgZGeycPf3eIA.t
 pOSZL.J77wGARq8Z9Q2L5wv7lyBicWcEv_LIUdvz45N01MQjWE1GmMt.8Qjca.vC9o.G56kbXSg7
 KeX_wgZDOm4G7m6p6bAro0WiRMKczNjTH4WZXx7pIFT6UYGfc8JWTfljCIOtDgeFUV.8uGkn.zZ0
 WPPkcRfiXFq6ft36aGY4jAd6rXjyzh3zsexw3h6aXD6SJ9C4WfUvCxc.62lJUUjx7uZXFSG6GWpI
 9WCWOLh.zogHV8fahiNXPAlzdh.gFy7Ixjv7v1h9YFXCnEFJrONSjBbT6tDizNubevEDvLMH3.T0
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 30 Mar 2020 02:38:56 +0000
Received: by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0ff86b82b40f8556fdf33f02e5fb3ea4;
          Mon, 30 Mar 2020 02:38:51 +0000 (UTC)
Date:   Mon, 30 Mar 2020 10:38:40 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>
Subject: [GIT PULL] erofs updates for 5.7-rc1
Message-ID: <20200330023830.GA5112@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20200330023830.GA5112.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.15555 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.7-rc1?

Another maintaining updates with a XArray adaptation, several fixes
for shrinker and corrupted images are ready for this cycle.

All commits have been stress tested with no noticeable smoke out and
have been in linux-next as well. This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.7-rc1

for you to fetch changes up to 20741a6e146cab59745c7f25abf49d891a83f8e9:

  MAINTAINERS: erofs: update my email address (2020-03-28 14:12:33 +0800)

----------------------------------------------------------------
Changes since last update:

 - Convert radix tree usage to XArray;

 - Fix shrink scan count on multiple filesystem instances;

 - Better handling for specific corrupted images;

 - Update my email address in MAINTAINERS.

----------------------------------------------------------------
Gao Xiang (5):
      erofs: convert workstn to XArray
      erofs: correct the remaining shrink objects
      erofs: use LZ4_decompress_safe() for full decoding
      erofs: handle corrupted images whose decompressed size less than it'd be
      MAINTAINERS: erofs: update my email address

 MAINTAINERS             |  2 +-
 fs/erofs/decompressor.c | 22 ++++++++----
 fs/erofs/internal.h     |  8 ++---
 fs/erofs/super.c        |  2 +-
 fs/erofs/utils.c        | 90 ++++++++++++++++++-------------------------------
 fs/erofs/zdata.c        | 76 +++++++++++++++++++++--------------------
 6 files changed, 94 insertions(+), 106 deletions(-)

