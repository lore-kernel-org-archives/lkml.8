Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B70C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E94D20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ypg0SOMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGWXVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgGWXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:21:28 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820BC0619E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:21:27 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6EF21891B3;
        Fri, 24 Jul 2020 11:21:24 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1595546484;
        bh=27Rf7c0sMrO2x585TIZH/W6JNKUcsP81RWV+FdFnYfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ypg0SOMInXz2fhDt+KpaU2J+qPLJr+1X0En90HZuPqdIHY03GqpSmkc0U2mWSZVFk
         RQhh+F4ozVfNceU7o/Jh9D+a3g/tcKTW+jTPqAMY+scTKSj2XVfyj0I4L6hlGzUkyr
         Snh4zTYUdEdEEDtGifPYYy86UV4cqUWJP6EyJ5leS/5X8WI+fvUC1gWG9fzAdgat6n
         1tbDBm08I9UeyeckMeBt9BjkboXMyjJGucWikNZWnibPZVlFDrnGefDC3omIhkAhv9
         i7lC3RhU9T1s52fozkK0VLhBdVLDfZjv3PtS9S8dVFDTLPKeR7H8ZVs8ZtkPbecBsT
         rJsYsCu8aPJyg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f1a1b720003>; Fri, 24 Jul 2020 11:21:22 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 14D3813EEB7;
        Fri, 24 Jul 2020 11:21:24 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3EE89280079; Fri, 24 Jul 2020 11:21:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/3] net: dsa: mv88e6xxx: Support jumbo configuration on 6190/6190X
Date:   Fri, 24 Jul 2020 11:21:21 +1200
Message-Id: <20200723232122.5384-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723232122.5384-1-chris.packham@alliedtelesis.co.nz>
References: <20200723232122.5384-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MV88E6190 and MV88E6190X both support per port jumbo configuration
just like the other GE switches. Install the appropriate ops.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
I'm including this change in my series for completeness. Looking at the
datasheets I think this is an unintentional omission but I don't have act=
ual
hardware to test this change on so some testing from someone with access =
to the
right chip would be appreciated.

Changes in v2:
- Add review from Andrew

 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx=
/chip.c
index 4ddb6f3035c9..43a2ab8cf2c8 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3958,6 +3958,7 @@ static const struct mv88e6xxx_ops mv88e6190_ops =3D=
 {
 	.port_set_frame_mode =3D mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods =3D mv88e6352_port_set_egress_floods,
 	.port_set_ether_type =3D mv88e6351_port_set_ether_type,
+	.port_set_jumbo_size =3D mv88e6165_port_set_jumbo_size,
 	.port_pause_limit =3D mv88e6390_port_pause_limit,
 	.port_disable_learn_limit =3D mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override =3D mv88e6xxx_port_disable_pri_override,
@@ -4016,6 +4017,7 @@ static const struct mv88e6xxx_ops mv88e6190x_ops =3D=
 {
 	.port_set_frame_mode =3D mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods =3D mv88e6352_port_set_egress_floods,
 	.port_set_ether_type =3D mv88e6351_port_set_ether_type,
+	.port_set_jumbo_size =3D mv88e6165_port_set_jumbo_size,
 	.port_pause_limit =3D mv88e6390_port_pause_limit,
 	.port_disable_learn_limit =3D mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override =3D mv88e6xxx_port_disable_pri_override,
--=20
2.27.0

