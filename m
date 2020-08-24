Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F323C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35CE207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598296269;
	bh=DY5YdDtRH/sBtlYsJT+jT3P+dwjtVZPXEXBijyAkmhE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ayLbkyp5U6tdnnz9cdV0SLfXJn59meYz9kuYQoIpn5qc9HRIuWRNZU5pxanqB4Lxk
	 Klu3ogn+ScGhvfiYCLfBLOpClLekU5ZuXwyBDx3NmaMAF3NmPVve1z/XvblJnFrOoI
	 shj2Tb6Ly465fCVkCVayR8IBEfGKwRROalXe03vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHXTLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXTLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:11:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16AA12074D;
        Mon, 24 Aug 2020 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296267;
        bh=DY5YdDtRH/sBtlYsJT+jT3P+dwjtVZPXEXBijyAkmhE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nCmRV7J3aRpKwTJ4AbNqP9s48C802UmXMLJR45bQ3rcdZ8VrK9ULff/zO5+u1LpVI
         BOKyjnfBi/aqE4egfqThzkk+AnrYUkoj5KCmmkON2bqHGrY4WOYUfEu49js3sYCLFa
         2pYCAf3dUt4dWXuWpyQ4x8Miec+EG5hHj9M2eQdI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200818062651.21680-1-vulab@iscas.ac.cn>
References: <20200818062651.21680-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] alarmtimer: convert comma to semicolon
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
To:     Xu Wang <vulab@iscas.ac.cn>, john.stultz@linaro.org,
        tglx@linutronix.de
Date:   Mon, 24 Aug 2020 12:11:05 -0700
Message-ID: <159829626574.334488.5559185765706667667@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xu Wang (2020-08-17 23:26:51)
> Replace a comma between expression statements by a semicolon.
>=20
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
