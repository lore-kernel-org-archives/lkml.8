Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171582072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591287949;
	bh=SJ0H+1p4mGGW0MR1ySEfCnOGQPdtXMwoEr8HGD6As50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FlL6hyZcPE6P4Fj4a9U1q491ypJqje0opg9eNmYcuniWhpdOtpG7KB6faDbIcmgWy
	 EsWwkhlSy6fMxFHtVZ+UPkOm+Od2nOCKJf9NMUh9oFtHWg2F7WN7isvTal7HyzwbTM
	 JryeJ8LOHw8rEUgPhEwWb2/uPDHNwR+nzBDeOQVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgFDQZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729540AbgFDQZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:25:48 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7E3206DC;
        Thu,  4 Jun 2020 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591287947;
        bh=SJ0H+1p4mGGW0MR1ySEfCnOGQPdtXMwoEr8HGD6As50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gPrq6cAdAFdx+P5K0305bzPqaFLATYeSUP6i6KlfgTMpovG/xJ9zzmui4PFAN5qn3
         uEcDHGg0SIDZDcgMygDablg1oQ+2VSDSpttIMblWNFIrVy4J2l0jOTkzv5dikGlpgI
         t3oYIF9erfN/QMu7jChMtYJFyod2mmZss/SSPTPM=
Date:   Thu, 4 Jun 2020 09:25:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v6 4/4] net: dp83869: Add RGMII internal delay
 configuration
Message-ID: <20200604092545.40c85fce@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200604111410.17918-5-dmurphy@ti.com>
References: <20200604111410.17918-1-dmurphy@ti.com>
        <20200604111410.17918-5-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 06:14:10 -0500 Dan Murphy wrote:
> Add RGMII internal delay configuration for Rx and Tx.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Hi Dan, please make sure W=3D1 C=3D1 build is clean:

drivers/net/phy/dp83869.c:103:18: warning: =C3=A2=E2=82=AC=CB=9Cdp83869_int=
ernal_delay=C3=A2=E2=82=AC=E2=84=A2 defined but not used [-Wunused-const-va=
riable=3D]
  103 | static const int dp83869_internal_delay[] =3D {250, 500, 750, 1000,=
 1250, 1500,
      |                  ^~~~~~~~~~~~~~~~~~~~~~

Also net-next is closed right now, you can post RFCs but normal patches
should be deferred until after net-next reopens.
