Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F4FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E244220772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593695521;
	bh=giOuJWzTkbHlW5F2N4y7TcNM6fnozOkTyNNF4tYNyLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cKo4PqQLXR6Rc8LzDdFx9FdBLFYbhgfWgqy3qCq0LxVkc/ky8GICStAwrNuqcsyFJ
	 6SMd8qUB0QdbAURvbdl8F96RNfoY7FyQak1KXdmB1sqUVgse1dq8A9n20TFGEcrOxB
	 e7cfk7nD58RHlzUhsZ7/dfRWHNet9vPGCS6XCE8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgGBNL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgGBNL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:11:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0EC20772;
        Thu,  2 Jul 2020 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593695516;
        bh=giOuJWzTkbHlW5F2N4y7TcNM6fnozOkTyNNF4tYNyLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MeT2PsfbjMC86fZNUKR8lHLwGTMPEqoxVC0OfcVXuwslXHP2lbhNrUCEGwN2BpMqC
         au6gNQq0WJ2FvURwr6xR8UPkIHjWS+2CiJTewMMV2AFslRLhBpUXZKl2dV+wyLWbyG
         88r72qSfRMZKBwjHduqYYOeGAh2B4oVnogY9y8eY=
Date:   Thu, 2 Jul 2020 16:11:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 0/6] Cleanup mlx5_ib main file
Message-ID: <20200702131152.GD4837@unreal>
References: <20200702081809.423482-1-leon@kernel.org>
 <20200702130809.GU23821@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702130809.GU23821@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 10:08:09AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 02, 2020 at 11:18:03AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Over the years, the main.c file grew above all imagination and was >8K
> > LOC of the code. This caused to a huge burden while I started to work on
> > ib_flow allocation patches.
> >
> > This series implements long standing "internal" wish to move flow logic
> > from the main to separate file.
> >
> > Based on
> > https://lore.kernel.org/linux-rdma/20200630101855.368895-4-leon@kernel.org
>
> Isn't this the series you said to drop? Can this be applied
> independently?

I asked to drop one patch in question, the one that revealed issue with
reference counting and convoluted error unwind flow.
https://lore.kernel.org/lkml/20200630145926.GA4837@unreal

It probably can be applied independently, but I didn't try.

Thanks

>
> Jason
