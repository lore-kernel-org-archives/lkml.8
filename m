Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B8EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E50620692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="zMrk9cTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgDIPFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:05:33 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43716 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgDIPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:05:33 -0400
Received: by mail-vs1-f68.google.com with SMTP id u11so4966793vsu.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wOr4sIJG9MjIWb5gIasStL1/2RcZWGgASEM+cd6V4A=;
        b=zMrk9cTVFfSASeJ/BOzeW53mSDwYDfZRsyn9ypQr27hkUJnGd57Bk1Fmtf2m8RWhU5
         hFfSCmSS5Jp0Kal/Ga5SqGDuzxKa1KRYI9qqHIGL7SmpWcKlk8W6dDh340tKzTKBFZti
         pXHxl8DqXw2khEOlv/ZoJmFytaCrUqb0Or4PnBKjjQgGJ16X06PFUP5SZlErKMr0aAi9
         ADeQuWlSEPaMoecYeG7d7aIMc3XUPa7gPe4Of4IQREQe5bLfcAjGhn97BwfBu/MfNbsj
         7IoJhJETiUf/9LUZYWYjV8r6oeKBe34MYjYVnzTfCntn3p9ZbGhAXVCenwCEksMluXLD
         EpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wOr4sIJG9MjIWb5gIasStL1/2RcZWGgASEM+cd6V4A=;
        b=Q5cQ7cvfUDJPXDSxbBbLcwd5Hc6GwJcfYMTl+s2wnY1cgA1EHe+3WSlJk3jGFBEXYQ
         o+ny5K/9jhXr3wyxPtPGhwcUInDVNxJa/CZtK0yP0E6V/HrE9fBzcSyiwh2c93MqrABy
         rKUEdbRmNf4D2bAfNCIL+lqfnDQykQHCUH67nhmYPkCPqEaJ0JWr2z6YCVj6/DqeQUh1
         zvxUY1MOI3qqBvJQ/f3+XdMYTl0YLTTqM2tWa59J0htSbacUHeyshX/1I0CFJN50Tw1F
         DI67aaFOuDjZFjVkaRA5j3HBHbcenx4rLOowPO1p4hsC3Qmuv9s5r5jRcQKpgEZ/v2U6
         FyZA==
X-Gm-Message-State: AGi0Pubxo6R1F5OOARn213mUARQPKLHPxMNSFOYzEAXsOF2Hcjt/A5yq
        G2wM50sRnkleTjAtDLDA2CI/DmsPJreEfsPyMmXiww==
X-Google-Smtp-Source: APiQypLshhcSaa4oPjvBf6sDo6HqRYfrNlqomIcbCtO1isz1E8qfdxx8DBUt7A0hRDnQc/O92NXtPf+hepSNxlS3QqU=
X-Received: by 2002:a05:6102:146:: with SMTP id a6mr313242vsr.237.1586444730502;
 Thu, 09 Apr 2020 08:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200409105253.1c86f4c8@canb.auug.org.au>
In-Reply-To: <20200409105253.1c86f4c8@canb.auug.org.au>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 9 Apr 2020 11:05:19 -0400
Message-ID: <CAOg9mSS0Kof75WpiGQtHPG4EZ8n_qK5yKF+h=Me2cD1CuaSe3g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the orangefs tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see all the other rst files, but no orangefs.rst...

I did see evidence on fs-devel a few months(?) ago that someone
was converting txt files to rst and that orangefs.txt
was one of them... perhaps there was something I should
have done but didn't? Anywho... what next?

[hubcap@hubcapsc linux]$ git log | grep ^commit | head -5
commit aa317d3351dee7cb0b27db808af0cd2340dcbaef  |  my commits I'll
commit 0e393a9a8f2a450862964451715d68e9a96a9c34  |  try to get pulled
commit ec95f1dedc9c64ac5a8b0bdb7c276936c70fdedd  |  this time
commit 7111951b8d4973bda27ff663f2cf18b663d15b48  <--- Linux 5.6
commit 570203ec830dd451b8804cdef8036f7fca9f0311
[hubcap@hubcapsc linux]$ find . -name orangefs.rst
[hubcap@hubcapsc linux]$

-Mike "only three more days in the merge window"

On Wed, Apr 8, 2020 at 8:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the orangefs tree got a conflict in:
>
>   Documentation/filesystems/orangefs.rst
>
> between commit:
>
>   18ccb2233fc5 ("docs: filesystems: convert orangefs.txt to ReST")
>
> from Linus' tree and commit:
>
>   aa317d3351de ("orangefs: clarify build steps for test server in orangefs.txt")
>
> from the orangefs tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc Documentation/filesystems/orangefs.rst
> index 7d6d4cad73c4,5a3865702a71..000000000000
> --- a/Documentation/filesystems/orangefs.rst
> +++ b/Documentation/filesystems/orangefs.rst
> @@@ -41,17 -38,7 +41,7 @@@ Documentatio
>
>   http://www.orangefs.org/documentation/
>
> -
> - Userspace Filesystem Source
> - ===========================
> -
> - http://www.orangefs.org/download
> -
> - Orangefs versions prior to 2.9.3 would not be compatible with the
> - upstream version of the kernel client.
> -
> -
>  -RUNNING ORANGEFS ON A SINGLE SERVER
>  +Running ORANGEFS On a Single Server
>   ===================================
>
>   OrangeFS is usually run in large installations with multiple servers and
> @@@ -73,29 -60,37 +63,37 @@@ single line.  Uncomment it and change t
>   controls clients which use libpvfs2.  This does not control the
>   pvfs2-client-core.
>
>  -Create the filesystem.
>  +Create the filesystem::
>
>  -pvfs2-server -f /etc/orangefs/orangefs.conf
>  +    pvfs2-server -f /etc/orangefs/orangefs.conf
>
>  -Start the server.
>  +Start the server::
>
>  -systemctl start orangefs-server
>  +    systemctl start orangefs-server
>
>  -Test the server.
>  +Test the server::
>
>  -pvfs2-ping -m /pvfsmnt
>  +    pvfs2-ping -m /pvfsmnt
>
>   Start the client.  The module must be compiled in or loaded before this
>  -point.
>  +point::
>
>  -systemctl start orangefs-client
>  +    systemctl start orangefs-client
>
>  -Mount the filesystem.
>  +Mount the filesystem::
>
>  -mount -t pvfs2 tcp://localhost:3334/orangefs /pvfsmnt
>  +    mount -t pvfs2 tcp://localhost:3334/orangefs /pvfsmnt
>
>  -USERSPACE FILESYSTEM SOURCE
> ++Userspace Filesystem Source
> + ===========================
> +
> + http://www.orangefs.org/download
> +
> + Orangefs versions prior to 2.9.3 would not be compatible with the
> + upstream version of the kernel client.
> +
>
>  -BUILDING ORANGEFS ON A SINGLE SERVER
>  +Building ORANGEFS on a Single Server
>   ====================================
>
>   Where OrangeFS cannot be installed from distribution packages, it may be
> @@@ -105,51 -100,55 +103,57 @@@ You can omit --prefix if you don't car
>   in /usr/local.  As of version 2.9.6, OrangeFS uses Berkeley DB by
>   default, we will probably be changing the default to LMDB soon.
>
>  -./configure --prefix=/opt/ofs --with-db-backend=lmdb --disable-usrint
>  +::
>
> -     ./configure --prefix=/opt/ofs --with-db-backend=lmdb
>  -make
> ++    ./configure --prefix=/opt/ofs --with-db-backend=lmdb --disable-usrint
>
>  -make install
>  +    make
>  +
>  +    make install
>
> - Create an orangefs config file::
> + Create an orangefs config file by running pvfs2-genconfig and
> + specifying a target config file. Pvfs2-genconfig will prompt you
> + through. Generally it works fine to take the defaults, but you
> + should use your server's hostname, rather than "localhost" when
>  -it comes to that question.
> ++it comes to that question::
>
>  -/opt/ofs/bin/pvfs2-genconfig /etc/pvfs2.conf
>  +    /opt/ofs/bin/pvfs2-genconfig /etc/pvfs2.conf
>
>  -Create an /etc/pvfs2tab file.
>  +Create an /etc/pvfs2tab file::
>
>  -Localhost is fine for your pvfs2tab file:
> ++    Localhost is fine for your pvfs2tab file.
> +
>  -echo tcp://localhost:3334/orangefs /pvfsmnt pvfs2 defaults,noauto 0 0 > \
>  -    /etc/pvfs2tab
>  +    echo tcp://localhost:3334/orangefs /pvfsmnt pvfs2 defaults,noauto 0 0 > \
>  +      /etc/pvfs2tab
>
>  -Create the mount point you specified in the tab file if needed.
>  +Create the mount point you specified in the tab file if needed::
>
>  -mkdir /pvfsmnt
>  +    mkdir /pvfsmnt
>
>  -Bootstrap the server.
>  +Bootstrap the server::
>
>  -/opt/ofs/sbin/pvfs2-server -f /etc/pvfs2.conf
>  +    /opt/ofs/sbin/pvfs2-server -f /etc/pvfs2.conf
>
>  -Start the server.
>  +Start the server::
>
> -     /opt/osf/sbin/pvfs2-server /etc/pvfs2.conf
>  -/opt/ofs/sbin/pvfs2-server /etc/pvfs2.conf
> ++    /opt/ofs/sbin/pvfs2-server /etc/pvfs2.conf
>
>   Now the server should be running. Pvfs2-ls is a simple
>  -test to verify that the server is running.
>  +test to verify that the server is running::
>
>  -/opt/ofs/bin/pvfs2-ls /pvfsmnt
>  +    /opt/ofs/bin/pvfs2-ls /pvfsmnt
>
>   If stuff seems to be working, load the kernel module and
>  -turn on the client core.
>  +turn on the client core::
>
> -     /opt/ofs/sbin/pvfs2-client -p /opt/osf/sbin/pvfs2-client-core
>  -/opt/ofs/sbin/pvfs2-client -p /opt/ofs/sbin/pvfs2-client-core
> ++    /opt/ofs/sbin/pvfs2-client -p /opt/ofs/sbin/pvfs2-client-core
>
>  -Mount your filesystem.
>  +Mount your filesystem::
>
> -     mount -t pvfs2 tcp://localhost:3334/orangefs /pvfsmnt
>  -mount -t pvfs2 tcp://`hostname`:3334/orangefs /pvfsmnt
> ++    mount -t pvfs2 tcp://`hostname`:3334/orangefs /pvfsmnt
>
>
>  -RUNNING XFSTESTS
>  +Running xfstests
>   ================
>
>   It is useful to use a scratch filesystem with xfstests.  This can be
