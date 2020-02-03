Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8276DC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566DF207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyqkCHaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgBCNh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:37:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51436 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgBCNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:37:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so15946367wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/2GSwnkg77BNm4nP5NyAu/SMCbCUCxlKEX7RXd5hGo=;
        b=QyqkCHaqANazKMga60HtjP7wB2dSFkmIppV/fL+3uluO6cMtGcuV1ZMB0HLtni0ufU
         NqMd+7iz+MQ2Xkn/nt6/x/3HL3ltE8PYfr1d9xoPjCNNcybC0Z17TX4G8fXfdg+6OsWy
         mmvaigLl5jz/yms5rEZEH5sY90O0ksKi1YnjEaJmzYfJdyzsRfXummetiPM41WEtjxSj
         0kLQ2w9BylCEXs6kkewgHQXiSTfiwjqKe3Ir6b/B5ZqLGJysVWzOl6b7Q8UBdkLhnIb0
         RmA6dpkRH8ULSn8vtmtCDiS7WkgPexSWNck1irp+0QDBHiK398L0VrhVjnri7tgDKbJT
         U4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/2GSwnkg77BNm4nP5NyAu/SMCbCUCxlKEX7RXd5hGo=;
        b=sAs6tNRlEwwhjOTFlB4d1Uq2p/nDVTUZN4ZvvNCUHK82BHw1jQKXoJgc/y97RZQPyf
         bvDvVptbkXlR58ggkouPtls2PNz9wMsXJ1v1VCBZKubCzv/x1GALOAEa0lrE61s1ohnw
         5CsK5YZJG8OFNim2qzVreR18EEa4sAwq3jjINGNiyzQO4P1kvJSyvU8y1B9rghLrQPij
         L4zPbki60xXr9tRN8fCBOTLM1VtdkaWeriEVl71fiDr+4Dc6PA+ApViz7I1cI1RZxq53
         IQS062/lFmr/jLMn5lMTP5tnBse1K3R2A/ac+esI54xzK1z96u4KG7t6WNu7xbX0r/Vj
         GRiA==
X-Gm-Message-State: APjAAAXJXww3vAYEYVL7gYIzhF5Bq7x8MSPUXAjTQ8bSiSdteF/8tWck
        ZSIm3udoFBnSBq5E1rQcBEjz/8JqpIekfFC82Zk=
X-Google-Smtp-Source: APXvYqyCHeEo+TF2vW137Ow69GfaGeid3s96v7had5ahLw8/ZMjxPFmMIZZzfzrfvrZ6vMtnWx4v3dJeeuqW7X3og3Y=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr28136509wmc.115.1580737043064;
 Mon, 03 Feb 2020 05:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20200203012702.GA8731@bombadil.infradead.org> <CACVXFVPyW9+oSPAv7-+=hExzktLkmPG=gYUY5acR5UGeJzTh0Q@mail.gmail.com>
 <20200203132334.GH8731@bombadil.infradead.org>
In-Reply-To: <20200203132334.GH8731@bombadil.infradead.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 3 Feb 2020 21:37:11 +0800
Message-ID: <CACVXFVNqP=oEZNiu=nebJ5EKKXfMfq7e=M1Ko1_TVw-FJTUpZw@mail.gmail.com>
Subject: Re: Current Linus tree protection fault in __kmalloc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gustavo@embeddedor.com, Clemens Ladisch <clemens@ladisch.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 9:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 03, 2020 at 06:47:03PM +0800, Ming Lei wrote:
> > On Mon, Feb 3, 2020 at 9:29 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > Anyone else seeing this?  My poor laptop has little compile grunt.
> >
> > It can be triggered in my VM every time, and has started git-bisect already.
>
> Glad to know it's not just me.  I finished a git bisect, but it
> pointed to a nonsense commit:
>
> git bisect start
> # bad: [a8ad62c76e8d082aa5fc3f2bd9f65d13ff2d5e8a] iomap: Convert from readpages to readahead
> git bisect bad a8ad62c76e8d082aa5fc3f2bd9f65d13ff2d5e8a
> # good: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
> git bisect good d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> # good: [aac96626713fe167c672f9a008be0f514aa3e237] Merge tag 'usb-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> git bisect good aac96626713fe167c672f9a008be0f514aa3e237
> # good: [d47c7f06268082bc0082a15297a07c0da59b0fc4] Merge branch 'linux-5.6' of git://github.com/skeggsb/linux into drm-next
> git bisect good d47c7f06268082bc0082a15297a07c0da59b0fc4
> # bad: [4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb] Merge tag 'for-v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
> git bisect bad 4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb
> # bad: [701a9c8092ddf299d7f90ab2d66b19b4526d1186] Merge tag 'char-misc-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> git bisect bad 701a9c8092ddf299d7f90ab2d66b19b4526d1186
> # good: [270f104ba26f0498aff85e5b002e2f4c2249c04b] staging: wfx: update TODO
> git bisect good 270f104ba26f0498aff85e5b002e2f4c2249c04b
> # good: [ca9b5b6283984f67434cee810f3b08e19630226d] Merge tag 'tty-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect good ca9b5b6283984f67434cee810f3b08e19630226d
> # good: [10d3e38c7923853967cea97513213bba923dde64] Merge tag 'icc-5.6-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next
> git bisect good 10d3e38c7923853967cea97513213bba923dde64
> # good: [b5909c6d16fd4e3972b0cd48dedde08d55575342] staging: kpc2000: rename variables with kpc namespace
> git bisect good b5909c6d16fd4e3972b0cd48dedde08d55575342
> # good: [72a9cc952f123948ca1d1011a12e5e1312140b68] devtmpfs: factor out common tail of devtmpfs_{create,delete}_node
> git bisect good 72a9cc952f123948ca1d1011a12e5e1312140b68
> # good: [2485055394be272d098ca7dd63193d5041fb8140] staging: most: core: drop device reference
> git bisect good 2485055394be272d098ca7dd63193d5041fb8140
> # good: [7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838] Merge tag 'staging-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect good 7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838
> # bad: [0db4a15d4c2787b1112001790d4f95bd2c5fed6f] mei: me: add jasper point DID
> git bisect bad 0db4a15d4c2787b1112001790d4f95bd2c5fed6f
> # bad: [987f028b8637cfa7658aa456ae73f8f21a7a7f6f] char: hpet: Use flexible-array member
> git bisect bad 987f028b8637cfa7658aa456ae73f8f21a7a7f6f
> # bad: [eb143f8756e77c8fcfc4d574922ae9efd3a43ca9] binder: fix log spam for existing debugfs file creation.
> git bisect bad eb143f8756e77c8fcfc4d574922ae9efd3a43ca9
> # first bad commit: [eb143f8756e77c8fcfc4d574922ae9efd3a43ca9] binder: fix log spam for existing debugfs file creation.
>
> The .config doesn't even have the binder enabled, which is the only file
> touched in the commit.
>

My git bisect is just done, and it points to the following commit:

commit 987f028b8637cfa7658aa456ae73f8f21a7a7f6f
Author: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date:   Mon Jan 20 17:53:26 2020 -0600

    char: hpet: Use flexible-array member

I have double checked the commit, and looks it is really the 1st bad one.

Thanks,
Ming Lei
