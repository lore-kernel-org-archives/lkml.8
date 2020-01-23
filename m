Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB12C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 06:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B11A2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579761976;
	bh=T3vIGKZC1bfw3mu1T/uU0TZlAZMQ/9TbOrBDWxrgMfE=;
	h=In-Reply-To:References:To:From:Subject:Date:List-ID:From;
	b=2COgqe6AdWLeps+S0P7DscyE/mydmDM4YRdwSJ6tlrytBgm4AebCNXFr6qQA3yVYO
	 4DSW4PtSin/5bLdKyLy4x1qB39uzR7B9dDzEV/RN7X9j52i6nEMpOax5BMtaW14CCI
	 oXEQCgX449okj3tflK24GEVKcaG1aD93KhZPLAvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAWGqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 01:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAWGqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 01:46:15 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78346217F4;
        Thu, 23 Jan 2020 06:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579761974;
        bh=T3vIGKZC1bfw3mu1T/uU0TZlAZMQ/9TbOrBDWxrgMfE=;
        h=In-Reply-To:References:To:From:Subject:Date:From;
        b=hsoi5gkWuNCLOIdDRxnpJEm08tN6cjSyI1suOqT/8ebYNe3ltG6ctwlRHSTwAlZKG
         pN6p/6qWbUCHUthBWt6PCWBCNuk+qQQGyXanRUtqD3QBZaZPqmG1Deu0j83DUSAXla
         VyOPHlN4gc/lIdAsagkBJ0NBjsPS7I69Oq0JzNns=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579217994-22219-3-git-send-email-vnkgutta@codeaurora.org>
References: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org> <1579217994-22219-3-git-send-email-vnkgutta@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, jshriram@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, psodagud@codeaurora.org,
        robh+dt@kernel.org, tdas@codeaurora.org, tsoni@codeaurora.org,
        vinod.koul@linaro.org, vnkgutta@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/7] clk: qcom: rpmh: Add support for RPMH clocks on SM8250
User-Agent: alot/0.8.1
Date:   Wed, 22 Jan 2020 22:46:13 -0800
Message-Id: <20200123064614.78346217F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Venkata Narendra Kumar Gutta (2020-01-16 15:39:49)
> @@ -490,6 +512,7 @@ static int clk_rpmh_probe(struct platform_device *pde=
v)
>         { .compatible =3D "qcom,sdm845-rpmh-clk", .data =3D &clk_rpmh_sdm=
845},
>         { .compatible =3D "qcom,sm8150-rpmh-clk", .data =3D &clk_rpmh_sm8=
150},
>         { .compatible =3D "qcom,sc7180-rpmh-clk", .data =3D &clk_rpmh_sc7=
180},
> +       { .compatible =3D "qcom,sm8250-rpmh-clk",  .data =3D &clk_rpmh_sm=
8250},

We should sort this on compatible.

>         { }
>  };
>  MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
