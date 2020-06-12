Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFCCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1F7206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592004057;
	bh=JdvVR8J+0Arq0tXeW9/9q0jFaxqp5FHjrh5Fi4PYHUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vV6wdZ+yzvud0GY4ZCKqIjBJAkGL2n4xAN4RaRtAV12c3BVsR4Th02YbeGohYRxJL
	 ibJ3qIzWuVLlDtpr72qz2QdVPOrjLC04Qp9HhtLnJIfA2RX2jzpttkwj4Z8fD9G1Am
	 /hojC221Kqxub6rfgYckofTZRPIYQdddNnTKgYK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFLXUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgFLXUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:20:54 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D9D20791;
        Fri, 12 Jun 2020 23:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592004052;
        bh=JdvVR8J+0Arq0tXeW9/9q0jFaxqp5FHjrh5Fi4PYHUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BZJGYZXTVC5fEfEo9aDgLoF+lLSZqn/1E9Ro6gzQIQTQ+Dy0ymov/CMHsC9AsJpjy
         X8ax0zAs0ypeuGdX7TAQGwyAHuBa7D9pIn2moU8z53+zGIGe1DQakgYW7pIp9UjoSv
         kZbERL5yJIdPCcqOFM7N5DeO0VpuTnYXbBLiJtSs=
Received: by mail-ed1-f53.google.com with SMTP id e12so7566830eds.2;
        Fri, 12 Jun 2020 16:20:52 -0700 (PDT)
X-Gm-Message-State: AOAM530Xfi+5jGLzjc0vW8U87QYQr27uZ5JOHhFJbfgT/nx5cN4EN6cM
        8OJZr9aolFy6Ut+Mu1fZTu4WG4IeE33a2oy+rA==
X-Google-Smtp-Source: ABdhPJws2pVpLs9hWd6fCIoX5bpx8NMabFR2tCPg7vlta4vfaE2m6DMZc+cNmafO6twqRpf/nVam21nmIJUmNVp7DcQ=
X-Received: by 2002:aa7:c4c7:: with SMTP id p7mr14451531edr.271.1592004050816;
 Fri, 12 Jun 2020 16:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com> <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 13 Jun 2020 07:20:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-KDTKPRnOsa3xtr=PGy4EEdKbaXVTUdpo3osyrfzD3-g@mail.gmail.com>
Message-ID: <CAAOTY_-KDTKPRnOsa3xtr=PGy4EEdKbaXVTUdpo3osyrfzD3-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=889=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MT6873 bus frabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violations are logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by devapc-mt6873 driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>

[snip]

> +
> +/*
> + * sramrom_vio_handler - clean sramrom violation & print violation infor=
mation
> + *                      for debugging.
> + */
> +static void sramrom_vio_handler(void)
> +{
> +       const struct mtk_sramrom_sec_vio_desc *sramrom_vios;
> +       struct mtk_devapc_vio_info *vio_info;
> +       struct arm_smccc_res res;
> +       size_t sramrom_vio_sta;
> +       int sramrom_vio;
> +       u32 rw;
> +
> +       sramrom_vios =3D mtk_devapc_ctx->soc->sramrom_sec_vios;
> +       vio_info =3D mtk_devapc_ctx->soc->vio_info;
> +
> +       arm_smccc_smc(MTK_SIP_KERNEL_CLR_SRAMROM_VIO,
> +                     0, 0, 0, 0, 0, 0, 0, &res);
> +
> +       sramrom_vio =3D res.a0;
> +       sramrom_vio_sta =3D res.a1;
> +       vio_info->vio_addr =3D res.a2;
> +
> +       if (sramrom_vio =3D=3D SRAM_VIOLATION)
> +               pr_info(PFX "%s, SRAM violation is triggered\n", __func__=
);
> +       else if (sramrom_vio =3D=3D ROM_VIOLATION)
> +               pr_info(PFX "%s, ROM violation is triggered\n", __func__)=
;
> +       else
> +               return;
> +
> +       vio_info->master_id =3D (sramrom_vio_sta & sramrom_vios->vio_id_m=
ask)
> +                       >> sramrom_vios->vio_id_shift;
> +       vio_info->domain_id =3D (sramrom_vio_sta & sramrom_vios->vio_doma=
in_mask)
> +                       >> sramrom_vios->vio_domain_shift;
> +       rw =3D (sramrom_vio_sta & sramrom_vios->vio_rw_mask) >>
> +                       sramrom_vios->vio_rw_shift;

I think some information, such as master_id, would be get in
devapc_extract_vio_dbg(), you need not to get it here.

> +
> +       if (rw)
> +               vio_info->write =3D 1;
> +       else
> +               vio_info->read =3D 1;
> +
> +       pr_info(PFX "%s: %s:0x%x, %s:0x%x, %s:%s, %s:0x%x\n",
> +               __func__, "master_id", vio_info->master_id,
> +               "domain_id", vio_info->domain_id,
> +               "rw", rw ? "Write" : "Read",
> +               "vio_addr", vio_info->vio_addr);
> +}
> +

[snip]

> +
> +/*
> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) wil=
l dump
> + *                       violation information including which master vi=
olates
> + *                       access slave.
> + */
> +static irqreturn_t devapc_violation_irq(int irq_number, void *dev_id)
> +{
> +       u32 slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;

Don't make  mtk_devapc_ctx a global variable. You should allocate
instance of  mtk_devapc_ctx in probe(), and pass  mtk_devapc_ctx to
the last parameter of devm_request_irq(), and it would be the second
parameter of irq handler.

> +       const struct mtk_device_info **device_info;
> +       struct mtk_devapc_vio_info *vio_info;
> +       int slave_type, vio_idx, index;
> +       const char *vio_master;
> +       unsigned long flags;
> +       bool normal;
> +       u8 perm;
> +
> +       spin_lock_irqsave(&devapc_lock, flags);
> +
> +       device_info =3D mtk_devapc_ctx->soc->device_info;
> +       vio_info =3D mtk_devapc_ctx->soc->vio_info;
> +       normal =3D false;
> +       vio_idx =3D -1;
> +       index =3D -1;
> +
> +       /* There are multiple DEVAPC_PD */
> +       for (slave_type =3D 0; slave_type < slave_type_num; slave_type++)=
 {
> +               if (!check_type2_vio_status(slave_type, &vio_idx, &index)=
)
> +                       if (!mtk_devapc_dump_vio_dbg(slave_type, &vio_idx=
,
> +                                                    &index))
> +                               continue;
> +
> +               /* Ensure that violation info are written before
> +                * further operations
> +                */
> +               smp_mb();
> +               normal =3D true;
> +
> +               mask_module_irq(slave_type, vio_idx, true);
> +
> +               if (clear_vio_status(slave_type, vio_idx))
> +                       pr_warn(PFX "%s, %s:0x%x, %s:0x%x\n",
> +                               "clear vio status failed",
> +                               "slave_type", slave_type,
> +                               "vio_index", vio_idx);
> +
> +               perm =3D get_permission(slave_type, index, vio_info->doma=
in_id);
> +
> +               vio_master =3D mtk_devapc_ctx->soc->master_get
> +                       (vio_info->master_id,
> +                        vio_info->vio_addr,
> +                        slave_type,
> +                        vio_info->shift_sta_bit,
> +                        vio_info->domain_id);
> +
> +               if (!vio_master) {
> +                       pr_warn(PFX "master_get failed\n");
> +                       vio_master =3D "UNKNOWN_MASTER";
> +               }
> +
> +               pr_info(PFX "%s - %s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> +                       "Violation", "slave_type", slave_type,
> +                       "sys_index",
> +                       device_info[slave_type][index].sys_index,
> +                       "ctrl_index",
> +                       device_info[slave_type][index].ctrl_index,
> +                       "vio_index",
> +                       device_info[slave_type][index].vio_index);
> +
> +               pr_info(PFX "%s %s %s %s\n",
> +                       "Violation - master:", vio_master,
> +                       "access violation slave:",
> +                       device_info[slave_type][index].device);
> +
> +               devapc_vio_reason(perm);
> +
> +               devapc_extra_handler(slave_type, vio_master, vio_idx,
> +                                    vio_info->vio_addr);
> +
> +               mask_module_irq(slave_type, vio_idx, false);
> +       }
> +
> +       if (normal) {
> +               spin_unlock_irqrestore(&devapc_lock, flags);
> +               return IRQ_HANDLED;
> +       }
> +
> +       spin_unlock_irqrestore(&devapc_lock, flags);
> +       return IRQ_HANDLED;
> +}
> +

[snip]

> +
> +int mtk_devapc_probe(struct platform_device *pdev, struct mtk_devapc_soc=
 *soc)
> +{
> +       struct device_node *node =3D pdev->dev.of_node;
> +       u32 slave_type_num;
> +       int slave_type;
> +       int ret;
> +
> +       if (IS_ERR(node))
> +               return -ENODEV;
> +
> +       mtk_devapc_ctx->soc =3D soc;
> +       slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;
> +
> +       for (slave_type =3D 0; slave_type < slave_type_num; slave_type++)=
 {
> +               mtk_devapc_ctx->devapc_pd_base[slave_type] =3D
> +                       of_iomap(node, slave_type);
> +               if (!mtk_devapc_ctx->devapc_pd_base[slave_type])
> +                       return -EINVAL;
> +       }
> +
> +       mtk_devapc_ctx->infracfg_base =3D of_iomap(node, slave_type_num +=
 1);
> +       if (!mtk_devapc_ctx->infracfg_base)
> +               return -EINVAL;
> +
> +       mtk_devapc_ctx->devapc_irq =3D irq_of_parse_and_map(node, 0);
> +       if (!mtk_devapc_ctx->devapc_irq)
> +               return -EINVAL;
> +
> +       /* CCF (Common Clock Framework) */
> +       mtk_devapc_ctx->devapc_infra_clk =3D devm_clk_get(&pdev->dev,
> +                                                       "devapc-infra-clo=
ck");
> +
> +       if (IS_ERR(mtk_devapc_ctx->devapc_infra_clk))
> +               return -EINVAL;
> +
> +       proc_create("devapc_dbg", 0664, NULL, &devapc_dbg_fops);
> +
> +       if (clk_prepare_enable(mtk_devapc_ctx->devapc_infra_clk))
> +               return -EINVAL;
> +
> +       start_devapc();
> +
> +       ret =3D devm_request_irq(&pdev->dev, mtk_devapc_ctx->devapc_irq,
> +                              (irq_handler_t)devapc_violation_irq,
> +                              IRQF_TRIGGER_NONE, "devapc", NULL);
> +       if (ret) {
> +               pr_err(PFX "request devapc irq failed, ret:%d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_devapc_probe);

Why export probe function?

> +
> +int mtk_devapc_remove(struct platform_device *dev)
> +{
> +       clk_disable_unprepare(mtk_devapc_ctx->devapc_infra_clk);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_devapc_remove);

Ditto.

Regards,
Chun-Kuang.
