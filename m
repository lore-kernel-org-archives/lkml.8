Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFF0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B26206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="rgvoc4Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHJUSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:18:50 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:61329 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgHJUSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:18:49 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQS3D1L69z2d;
        Mon, 10 Aug 2020 22:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597090728; bh=Xmfb8zsAkxfDxo5q9Pvfw9Rt6fPeNww71CuPr1jQ9xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgvoc4TiD576FsrwhADojhjnndnhMNkW97NwSKRuGuqTgX3znuOb/tJD66X92TkfT
         0x3lSxY/hcObGOORQUvZ03OkuXS8X25Khr9rXR3wQ897Ye0wyrOy9B8yN/eOaleBQi
         ZpMiKXxvWmzOvxPOSY8wNx/PAcbxr8Fz8sadENyNPi9k5EEDYgn2w14Rx1G0GJQHW6
         MfuN54EdrePCJQnw8mfKCRerD+iBGBHvhNHzE57Af4kaRORK7F6OCY8Di6N6XV/NXv
         vc4vAyz/oUj0JO0n0hZlVep0HXyPLKIqmu9KTpCadZyrXlZ+L/r3M0CWw6rILgN24C
         AfR4U7yhtsatg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 22:18:46 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: regulator: deadlock vs memory reclaim
Message-ID: <20200810201846.GA12091@qmqm.qmqm.pl>
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
 <9a5c8ca6-2027-4d89-e290-6db564b99962@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a5c8ca6-2027-4d89-e290-6db564b99962@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:15:28PM +0300, Dmitry Osipenko wrote:
> 10.08.2020 23:09, Michał Mirosław пишет:
> > At first I also thought so, but there's more. Below is a lockdep
> > complaint with your patch applied. I did a similar patch and then two more
> > (following) and that is still not enough (sysfs/debugfs do allocations,
> > too).
> Then it should be good to move the locking for init_coupling() like I
> suggested and use GFP_NOWAIT for the two other cases. It all could be a
> single small patch. Could you please check whether GFP_NOWAIT helps?

This would be equivalent to my patches. Problem with sysfs and debugfs
remains as they don't have the option of GFP_NOWAIT. This needs to be
moved outside of the locks.

Best Regards,
Michał Mirosław
