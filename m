Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2665BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35D120776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590707564;
	bh=VGj2i8flL9JlQmAgKNzGrKzB+vOOk0rvJ232QmrQW+U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=snUV6WD4WwMaHG+8L3C8hNeNUjP0GQjm15JE6kBNwPWrmeDG7ZtS6BK+Kz+DzLXLD
	 CosPIcl5Ijn+fN46HLv54CGQo9z1nm4aFh+Q4NOBnW/7xaLIyjVvpxCRcuUiJJBeAP
	 RRKj6MptE4HP9twR62sUl/g9LixQddmajO8dvrMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391562AbgE1XMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389436AbgE1XMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:12:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6E520776;
        Thu, 28 May 2020 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590707558;
        bh=VGj2i8flL9JlQmAgKNzGrKzB+vOOk0rvJ232QmrQW+U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SObhxzW0L9TD8+lQKsRJoVJbBChIFc11d9J4X/Xct+03ugNYxr56U2xTRNwgn7dHB
         aExWegMQLCmeVfn7ykME1aGYMtvOKHaaYYjziXI/cHRzY7cDqQV20dImop//7idsQ9
         id34cjmGl/0MApGajyGtOqF4UTajggOQNMSVEIZ0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2c8cd31a-46ba-ec6a-67a7-f3d9abe561ff@xilinx.com>
References: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com> <1584048699-24186-3-git-send-email-jolly.shah@xilinx.com> <159054169658.88029.371843532116000844@swboyd.mtv.corp.google.com> <2c8cd31a-46ba-ec6a-67a7-f3d9abe561ff@xilinx.com>
Subject: Re: [PATCH v2 2/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
To:     Jolly Shah <jolly.shah@xilinx.com>, arm@kernel.org,
        linux-clk@vger.kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, olof@lixom.net
Date:   Thu, 28 May 2020 16:12:37 -0700
Message-ID: <159070755756.69627.18401650656284023600@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2020-05-28 10:44:01)
> Hi Stephan,
>=20
> Thanks for the review.
>=20
>  > ------Original Message------
>  > From: Stephen Boyd <sboyd@kernel.org>
>  > Sent:  Tuesday, May 26, 2020 6:08PM
>  > To: Jolly Shah <jolly.shah@xilinx.com>, Arm <arm@kernel.org>,=20
> Linux-clk <linux-clk@vger.kernel.org>, Michal Simek=20
> <michal.simek@xilinx.com>, Mturquette <mturquette@baylibre.com>, Olof=20
> <olof@lixom.net>
>  > Cc: Rajan Vaja <rajanv@xilinx.com>,=20
> Linux-arm-kernel@lists.infradead.org=20
> <linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org=20
> <linux-kernel@vger.kernel.org>, Tejas Patel <tejas.patel@xilinx.com>,=20
> Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jolly.shah@xilinx.com>
>  > Subject: Re: [PATCH v2 2/2] drivers: clk: zynqmp: Update fraction=20
> clock check from custom type flags
>  >
> > Quoting Jolly Shah (2020-03-12 14:31:39)
> >> From: Tejas Patel <tejas.patel@xilinx.com>
> >>
> >> Older firmware version sets BIT(13) in clkflag to mark a
> >> divider as fractional divider. Updated firmware version sets BIT(4)
> >> in type flags to mark a divider as fractional divider since
> >> BIT(13) is defined as CLK_DUTY_CYCLE_PARENT in the common clk
> >> framework flags.
> >>
> >> To support both old and new firmware version, consider BIT(13) from
> >> clkflag and BIT(4) from type_flag to check if divider is fractional
> >> or not.
> >>
> >> To maintain compatibility BIT(13) of clkflag in firmware will not be
> >> used in future for any purpose and will be marked as unused.
> >=20
> > Why are we mixing the firmware flags with the ccf flags? They shouldn't
> > be the same. The firmware should have its own 'flag numberspace' that is
> > distinct from the common clk framework's 'flag numberspace'. Please fix
> > the code.
> >=20
>=20
> Yes firmware flags are using separate numberspace now. Firmware=20
> maintains CCF and firmware specific flags separately but earlier=20
> CLK_FRAC was mistakenly defined in ccf flagspace and hence handled here=20
> for backward compatibility. Driver takes care of not registering same=20
> with CCF. Let me know if I misunderstood.

Why is the firmware maintaining CCF specific flags? The firmware
shouldn't know about the CCF flag numbering at all. We can change the
numbers that the CCF flags are assigned to randomly and that shouldn't
mean that the firmware needs to change. Maybe I should apply this patch?

---8<----
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bd1ee9039558..c1f36bca85b0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -16,22 +16,22 @@
  *
  * Please update clk_flags[] in drivers/clk/clk.c when making changes here!
  */
-#define CLK_SET_RATE_GATE	BIT(0) /* must be gated across rate change */
-#define CLK_SET_PARENT_GATE	BIT(1) /* must be gated across re-parent */
-#define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
-#define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
+#define CLK_SET_RATE_GATE	BIT(13) /* must be gated across rate change */
+#define CLK_SET_PARENT_GATE	BIT(2) /* must be gated across re-parent */
+#define CLK_SET_RATE_PARENT	BIT(3) /* propagate rate change up one level */
+#define CLK_IGNORE_UNUSED	BIT(4) /* do not gate even if unused */
 				/* unused */
 				/* unused */
-#define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
-#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change =
*/
-#define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accur=
acy */
-#define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
-#define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
-#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
+#define CLK_GET_RATE_NOCACHE	BIT(5) /* do not use the cached clk rate */
+#define CLK_SET_RATE_NO_REPARENT BIT(6) /* don't re-parent on rate change =
*/
+#define CLK_GET_ACCURACY_NOCACHE BIT(7) /* do not use the cached clk accur=
acy */
+#define CLK_RECALC_NEW_RATES	BIT(8) /* recalc rates after notifications */
+#define CLK_SET_RATE_UNGATE	BIT(9) /* clock needs to run to set rate */
+#define CLK_IS_CRITICAL		BIT(10) /* do not gate, ever */
 /* parents need enable during gate/ungate, set rate and re-parent */
-#define CLK_OPS_PARENT_ENABLE	BIT(12)
+#define CLK_OPS_PARENT_ENABLE	BIT(11)
 /* duty cycle call may be forwarded to the parent clock */
-#define CLK_DUTY_CYCLE_PARENT	BIT(13)
+#define CLK_DUTY_CYCLE_PARENT	BIT(12)
=20
 struct clk;
 struct clk_hw;
