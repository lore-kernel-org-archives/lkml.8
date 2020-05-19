Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C71C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168412081A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589899915;
	bh=Zzrxy9cnazliEWrlIB15AC7r330IHi741R32Bbnvffc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FB+iNhkR8AZ3s5oD20gb9OXfLL6bqb+neVMIUipJZu68sPaMO5NI/vGNXMcg3RnXi
	 QCpjNJv+RSjREKpZCgvMepgDVDt2I8gdWaaJikZufldDRaZ0ady3HwenNjYaBJPALa
	 LXqrV6S13EIdZGWDWUYYYkTCqFCe7c4YDp9vTDDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgESOvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgESOvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:51:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6015207D8;
        Tue, 19 May 2020 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589899913;
        bh=Zzrxy9cnazliEWrlIB15AC7r330IHi741R32Bbnvffc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=elbsIbehKMUPb6gsMgsVjgDQtTgLCXpuC2/zYeUAqVxXxNxaUDnx9SERduXJnE5BE
         3UAn7By/o1ofEjJnuNW+AYvusCq/8AXirGM5ANpIKD1NZjG0SLivHiBBo19VRav0FB
         31dYtk362fDfujYlVdiQ2JPNlRJb4a+/s7I8e8Qs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jb3ax-00DdPE-3N; Tue, 19 May 2020 15:51:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 May 2020 15:51:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, julien.thierry.kdev@gmail.com
Subject: Re: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as
 pseudo NMI
In-Reply-To: <CAFA6WYO3=BHX1exF+J=93ECnQFe3S5O4HrT4t14euw3t9PXE7A@mail.gmail.com>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org>
 <20200425112950.3a4815b6@why> <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org>
 <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
 <ac57cb4bbb6507ee98f199d68a514503@kernel.org>
 <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
 <20200430101322.420e4052@why>
 <CAFA6WYO+NGLfNkOah4YzXx5XuaDh=QtWHgnMBwwMFY1zRt15GQ@mail.gmail.com>
 <CAFA6WYPxiwxpJitX7fCSESUvQSa9Dq89GwL4e3w33ooetV=ysw@mail.gmail.com>
 <CAFA6WYOn+DLf77C1+e5bq-NdT+o4=o32oPu2b3bxD_U+mLQ3WQ@mail.gmail.com>
 <306aecc560a9503e500fbf1f512c6d30@kernel.org>
 <CAFA6WYPHWP46TY_XdxVVrTr6AChU_1ATXu+p32vXCjkaXWPWOQ@mail.gmail.com>
 <CAFA6WYO3=BHX1exF+J=93ECnQFe3S5O4HrT4t14euw3t9PXE7A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <53b74b80df5d64b2e702fd4de3eaffff@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, daniel.thompson@linaro.org, jason@lakedaemon.net, catalin.marinas@arm.com, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net, tglx@linutronix.de, will@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-13 11:02, Sumit Garg wrote:
> Hi Marc,
> 
> On Tue, 5 May 2020 at 17:03, Sumit Garg <sumit.garg@linaro.org> wrote:
>> 
>> On Tue, 5 May 2020 at 15:38, Marc Zyngier <maz@kernel.org> wrote:
>> >
>> > On 2020-05-05 05:09, Sumit Garg wrote:
>> > > On Fri, 1 May 2020 at 18:33, Sumit Garg <sumit.garg@linaro.org> wrote:
>> >
>> > [...]
>> >
>> > > In case there are no major objections to this approach, I will post
>> > > complete v2 patch-set (alongwith Marc's patches) for detailed review.
>> >
>> > As this is still a work in progress (I'm currently wrestling with
>> > the stupid RPi driver), whatever you have is unlikely to apply on
>> > top of the final series.
>> >
>> > I'm not going to stop you from posting the patches, it is just that
>> > they will be obsolete by the end of the week...
>> 
>> Thanks for the heads up. Will wait for your final series.
>> 
> 
> Were you able to give a final shape to your SGIs related patch-set?

See 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/ipi-as-irq

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
