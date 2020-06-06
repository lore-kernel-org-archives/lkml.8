Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 09:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32DB20663
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 09:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591434190;
	bh=fC/gCpvkFb7u3yKY51L/6vMoxU5Cruln6J8iTYu42ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQoiWGn5dCpxWcc6zrVWpzcqMwYpGi5HZjJi8+8iD60/3kJxgBqwpI2O3i+d6snBk
	 IdLhgWV+KPMQ8Rvjj28U0e1hMAuDXkbRwpLbAPPjDRVhuUicksEOi6j9YODk2cLCZj
	 GWILSiK4ulHOU8E5kaj0OcZ+5EAZ/orKUSm92was=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgFFJDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 05:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFFJDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 05:03:09 -0400
Received: from linux-8ccs.fritz.box (p57a23121.dip0.t-ipconnect.de [87.162.49.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5EB20663;
        Sat,  6 Jun 2020 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591434188;
        bh=fC/gCpvkFb7u3yKY51L/6vMoxU5Cruln6J8iTYu42ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AL8yqJuY2h3fGELtDOe89ZsoWgUiaJOj286fQlvFLG6WJF6/tSd2vOLAVX1aZFjer
         pq5kRLRAbNBGNL27NkQ/fGBsSh///D5TmxE8SuV7a7xAbNmlU5VZRskQrMljPxKt30
         Ix8JHhl9a0loQpwiIcQFOS2ZIOoxiPFWHU2rbMNA=
Date:   Sat, 6 Jun 2020 11:03:05 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Modules updates for v5.8
Message-ID: <20200606090304.GA11017@linux-8ccs.fritz.box>
References: <20200605093354.GA23721@linux-8ccs.fritz.box>
 <CAHk-=wgNqzQ0CUJ9LP+cLR8FMKwHTqOuSzqvFFKn7Duqquxo1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgNqzQ0CUJ9LP+cLR8FMKwHTqOuSzqvFFKn7Duqquxo1g@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Linus Torvalds [05/06/20 13:38 -0700]:
>On Fri, Jun 5, 2020 at 2:34 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> Please pull below to receive modules updates for the v5.8 merge window.
>
>Done. Considering the confusion this merge window with the
>dependencies of trees with each other, can you verify that what I got
>matches what you expect?

I reviewed the result of the merge and it matches what I expected. Thank you!
