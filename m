Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F1FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1906D20774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585559515;
	bh=M/zY77eHLeTEmIMgAYpOzNcqbjydR60IJtquEkYCTMs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dx3uVPCwgX2qtu16i/YFKompOHXJV3RmX0lV7InXedTiza4mKPgc9ba9JGnnLnpnp
	 vFb3HiDzm8SWfxLvJysz9AqEZRBo1w/E1Pd0qzD2Us1VZNmITFVJoezw0o9AO8Kkyi
	 z9MlouHiqu7LeACiYsG3PkxKdGefm/wAsjFgTsc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgC3JLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgC3JLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:11:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009FE206CC;
        Mon, 30 Mar 2020 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585559513;
        bh=M/zY77eHLeTEmIMgAYpOzNcqbjydR60IJtquEkYCTMs=;
        h=Date:From:To:Cc:Subject:From;
        b=a9RC4nX+uqOnIFgWvL9HeiSHMG07zPLYOFnv5bL8Rkm39HEeN4RM0J5Z16v4wC6p/
         feRM70DK3htR+QIRWu+tndoj+dKutbJSFNh/phFYIhs2S57qdnioL7KTEJBBKi/0ck
         G2Bos2AfoL4cxkdug9g9SNcRK9hEezwowv95MGiA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jIqSV-00GpBZ-84; Mon, 30 Mar 2020 10:11:51 +0100
Date:   Mon, 30 Mar 2020 10:11:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Email address update
Message-ID: <20200330101149.0e3263c7@why>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

It seems that I failed to update you on my email address change a few
months ago, and that you've been sending notices of issues with
linux/next [1] to my old address, which I don't have access to anymore.

Could you please replace all instances of marc.zyngier@arm.com with
maz@kernel.org as the point of contact for both the irqchip and kvm/arm
trees?

Thanks,

	M.

[1] https://lore.kernel.org/linux-next/20200326173656.691628e8@canb.auug.org.au/
-- 
Jazz is not dead. It just smells funny...
