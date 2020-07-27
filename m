Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C94C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE502074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595843640;
	bh=aU7nbbmxURhHho/spFo6gDr2WLaiWunOy8aTUFZfyYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XnRLB4rHo6zRGQnEBjWh9kSR/DucUpxT3WbKFNaXONHMo4rNSDuLO9nG8/RECsaek
	 d/hHqsJRiWJH7exeTzhwD0+P+u/r0E/uzUrIoO5bbv3RNgAgmG2nejc9U0EQXisnFG
	 L4EWFSfSmclSdU2TGCg2/5EQdmvY6GyeL0MoioCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgG0Jx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0Jx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:53:59 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207E52075A;
        Mon, 27 Jul 2020 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595843639;
        bh=aU7nbbmxURhHho/spFo6gDr2WLaiWunOy8aTUFZfyYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xu3uzXpNJykBSNJ3260iKq72+1Nhgv8bEp410kTYw7z+zhQcYwCMDMyVh6k10Kgmc
         A1c6O8cSu5tCq7zQoM20R+/NMhnmR0eKnOzGV+JryNTEUrqhWWuE8dsBAvhYmDctqL
         TJRGGklJK3K/qM0JqyhfYsRer8ZES2FwsPlStimk=
Date:   Mon, 27 Jul 2020 15:23:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul@crapouillou.net, prasannatsmkumar@gmail.com, kishon@ti.com,
        gor@linux.ibm.com, hca@linux.ibm.com,
        christophe.jaillet@wanadoo.fr, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: Re: [PATCH v6 3/5] USB: PHY: JZ4770: Add support for new Ingenic
 SoCs.
Message-ID: <20200727095355.GW12965@vkoul-mobl>
References: <20200725035159.31231-1-zhouyanjie@wanyeetech.com>
 <20200725035159.31231-4-zhouyanjie@wanyeetech.com>
 <87r1t0nmpr.fsf@kernel.org>
 <1727b5db-5cdf-b88a-4672-bfb4e9809bb0@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1727b5db-5cdf-b88a-4672-bfb4e9809bb0@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-20, 15:34, Zhou Yanjie wrote:
> Hi Felipe,
> 
> 在 2020/7/25 下午2:16, Felipe Balbi 写道:
> > Hi,
> > 
> > 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com> writes:
> > > Add support for probing the phy-jz4770 driver on the JZ4780 SoC,
> > > the X1000 SoC and the X1830 SoC from Ingenic.
> > > 
> > > Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> > > Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
> > > Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
> > > Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> > It would be better to move this driver to drivers/phy before adding
> > support for new SoCs. We want to remove drivers/usb/phy/ in the near
> > future, any help is welcome.
> > 
> Seems my mailbox have something wrong, the [5/5] patch in this series is
> used to move this river to drivers/phy, but seems that it has not been sent
> out correctly, I already resend it.

I have resend patches in my inbox but that seems missing patches too :(

-- 
~Vinod
