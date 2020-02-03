Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63678C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBF720674
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mEsLdC75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBCNXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:23:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBCNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/urUOF2v6vhv7B/0ZUR+IZTFcpQau2jBKsixLRMM4Yk=; b=mEsLdC75M0guRc02k/MTMAD4Lj
        Go4WiI48UfNzX9H6x0Pp7enqPdTQt797GtKX1rrS0VyoEMA/IeTomv7ywGQXUboxH6A9aqDFbHfba
        e6gSpST5lw5yuEzzuU7YRszh2lECR3B+MNooHjcC0xk5x5ADyn7WTcF6qASVdQJL2oSR9B2xNzQF+
        Qk/LcRBq4rIjezowktI7MxuOsDQlYtb1/uPfnoD3us/pvfQdLJPvOiTd1nsG25idH/KZOTww3SGku
        KOM88PA5uj8RRZPbxfX7T0YhWTxdal4q4FJHyOEdb21KJR3LqiEZkaNCnxhJkFAYyONKCphHUIolO
        FBiOeQJg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iybhO-0007vk-MI; Mon, 03 Feb 2020 13:23:34 +0000
Date:   Mon, 3 Feb 2020 05:23:34 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Current Linus tree protection fault in __kmalloc
Message-ID: <20200203132334.GH8731@bombadil.infradead.org>
References: <20200203012702.GA8731@bombadil.infradead.org>
 <CACVXFVPyW9+oSPAv7-+=hExzktLkmPG=gYUY5acR5UGeJzTh0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVPyW9+oSPAv7-+=hExzktLkmPG=gYUY5acR5UGeJzTh0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 06:47:03PM +0800, Ming Lei wrote:
> On Mon, Feb 3, 2020 at 9:29 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Anyone else seeing this?  My poor laptop has little compile grunt.
> 
> It can be triggered in my VM every time, and has started git-bisect already.

Glad to know it's not just me.  I finished a git bisect, but it
pointed to a nonsense commit:

git bisect start
# bad: [a8ad62c76e8d082aa5fc3f2bd9f65d13ff2d5e8a] iomap: Convert from readpages to readahead
git bisect bad a8ad62c76e8d082aa5fc3f2bd9f65d13ff2d5e8a
# good: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
git bisect good d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
# good: [aac96626713fe167c672f9a008be0f514aa3e237] Merge tag 'usb-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good aac96626713fe167c672f9a008be0f514aa3e237
# good: [d47c7f06268082bc0082a15297a07c0da59b0fc4] Merge branch 'linux-5.6' of git://github.com/skeggsb/linux into drm-next
git bisect good d47c7f06268082bc0082a15297a07c0da59b0fc4
# bad: [4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb] Merge tag 'for-v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
git bisect bad 4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb
# bad: [701a9c8092ddf299d7f90ab2d66b19b4526d1186] Merge tag 'char-misc-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad 701a9c8092ddf299d7f90ab2d66b19b4526d1186
# good: [270f104ba26f0498aff85e5b002e2f4c2249c04b] staging: wfx: update TODO
git bisect good 270f104ba26f0498aff85e5b002e2f4c2249c04b
# good: [ca9b5b6283984f67434cee810f3b08e19630226d] Merge tag 'tty-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good ca9b5b6283984f67434cee810f3b08e19630226d
# good: [10d3e38c7923853967cea97513213bba923dde64] Merge tag 'icc-5.6-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next
git bisect good 10d3e38c7923853967cea97513213bba923dde64
# good: [b5909c6d16fd4e3972b0cd48dedde08d55575342] staging: kpc2000: rename variables with kpc namespace
git bisect good b5909c6d16fd4e3972b0cd48dedde08d55575342
# good: [72a9cc952f123948ca1d1011a12e5e1312140b68] devtmpfs: factor out common tail of devtmpfs_{create,delete}_node
git bisect good 72a9cc952f123948ca1d1011a12e5e1312140b68
# good: [2485055394be272d098ca7dd63193d5041fb8140] staging: most: core: drop device reference
git bisect good 2485055394be272d098ca7dd63193d5041fb8140
# good: [7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838] Merge tag 'staging-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838
# bad: [0db4a15d4c2787b1112001790d4f95bd2c5fed6f] mei: me: add jasper point DID
git bisect bad 0db4a15d4c2787b1112001790d4f95bd2c5fed6f
# bad: [987f028b8637cfa7658aa456ae73f8f21a7a7f6f] char: hpet: Use flexible-array member
git bisect bad 987f028b8637cfa7658aa456ae73f8f21a7a7f6f
# bad: [eb143f8756e77c8fcfc4d574922ae9efd3a43ca9] binder: fix log spam for existing debugfs file creation.
git bisect bad eb143f8756e77c8fcfc4d574922ae9efd3a43ca9
# first bad commit: [eb143f8756e77c8fcfc4d574922ae9efd3a43ca9] binder: fix log spam for existing debugfs file creation.

The .config doesn't even have the binder enabled, which is the only file
touched in the commit.

