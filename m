Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10855C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB41F20772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592891881;
	bh=EfflRxj25NuPu89Qp7zFoEN+RP1nGLfWlSv3BKJ7o5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UL8UdBeWNa6Tu2uodckA1nJ8b3/BOsZn+zQpsZg9Hr6Q58y3Oxtxp/rp5kWUoPVhk
	 KKnT3XfTdhKfIdJppigeZY6VSpt/Z/oq0EtCHl5MT/x19gT1KWteaSG26mhhQf1Fjy
	 U4KSZzizWr1OURA2sJfDxt6evZ9dae8sJyKWoEvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgFWF6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgFWF6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:58:00 -0400
Received: from coco.lan (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC79420771;
        Tue, 23 Jun 2020 05:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592891879;
        bh=EfflRxj25NuPu89Qp7zFoEN+RP1nGLfWlSv3BKJ7o5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rXGvdonrD5hEQkEz9LbQof80d8YnLVIDTJ4Orxg1gdqGCf/e4WAsC4OcCEstQOPhT
         K+QVNya8zcZF3jBBTjD6o5Ig7WPjAjnaRD6zS9ArNg6Wkl+LRyqu5VhT/7i56VtWtk
         bGHs40qB1sp1IPzsmH+YcwQbJs8P1Mkn/mnfQFEg=
Date:   Tue, 23 Jun 2020 07:57:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] docs: f2fs: fix a broken table
Message-ID: <20200623075754.093c476d@coco.lan>
In-Reply-To: <20200622112209.71990f9c@lwn.net>
References: <20200622073907.7608a73a@lwn.net>
        <20200622171106.GA192855@gmail.com>
        <20200622112209.71990f9c@lwn.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 22 Jun 2020 11:22:09 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Mon, 22 Jun 2020 10:11:06 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > Someone already sent out a fix for this:
> > https://lkml.kernel.org/linux-doc/52f851cb5c9fd2ecae97deec7e168e66b8c295c3.1591137229.git.mchehab+huawei@kernel.org/

No problem from my side.

> > 
> > Is it intentional that you're sending out a different fix rather than applying
> > that one?  
> 
> It wasn't, actually, I'm just finding myself more than usually challenged
> these days.
> 
> That said, removing the table entirely seems ... excessive.  It's not
> terrible the way it is, or we could make it:

Jon,

I actually tried a patch close to yours before the patch I actually sent
upstream.

On my previous version, I was doing:

======================== =======================================================
...
test_dummy_encryption
test_dummy_encryption=%s Enable dummy encryption, which provides a fake fscrypt
			 context. The fake fscrypt context is used by xfstests.
			 The argument may be either "v1" or "v2", in order to
			 select the corresponding fscrypt policy version.
...
======================== =======================================================

The problem with the above is that Sphinx understood the first line as one row,
and the second one as a different one. So, the HTML output would be like:

<table>
...
<tr><td>test_dummy_encryption</td></tr>
<tr><td>test_dummy_encryption=%s</td>
<td>Enable dummy encryption, which provides a fake fscrypt
    context. The fake fscrypt context is used by xfstests.
    The argument may be either "v1" or "v2", in order to
    select the corresponding fscrypt policy version.</td>
</tr>

(e. g. it would look like the first parameter lacks description)

Which is not the intended result. I was unable to identify a way 
to teach Sphinx that the second line was a continuation of the
first (A ReST equivalent to placing a \ at the end of a line).

Still, the html output with the above is not that bad, and it should be clear
for readers that the description of the second parameter is also valid for the
first.


Thanks,
Mauro
