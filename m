Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AFBC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0230205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0/FH31v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCQNcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:32:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35546 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgCQNcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:32:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id d8so32395724qka.2;
        Tue, 17 Mar 2020 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wL0p3C5fBDyWra1AZHD6SjlbA8CpqssJuFeOi8qSncY=;
        b=H0/FH31v2bSBKeTvBtUBisoMnoZUvAuQcdlCr9ybScAu7w+v9VfQgXN1IpISvdoBY4
         Fu1jvk7u2ZzC2t/kL8q+2K63j9/yZx8v4KSSh/+vx1JN97lqeC/nv8vs66enpP1klb7H
         OPDAAZR91L0osPn4gx4kIBEUN5isind4wurJ9cIZpjj7PGuHwPJ2XKO8aCZJU4nA4tIs
         2NpZLdtplcEi/8NQ9nnXQIzIHiLM3d3O7FqE2fS7bABsQd3KjBEJdiKfOeyeZ7CErBXP
         n6/BAj0fp2acXiJfT9QOVBbSGsN3y+9wwaqpRHsAaRBF7V3dOMNnaW7/dC7vDAWWSh5s
         jAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wL0p3C5fBDyWra1AZHD6SjlbA8CpqssJuFeOi8qSncY=;
        b=oen75swpnilVfmc7Z7ZzDwiS3ltHTanAJ1JMhPNnIbbBPEsj2wuQcc7k6IlvemATRT
         pqrR3Mk9+moYwB4ULmQOO1sbk8EBh7HU9JPDQtbCu9MT7fPLBQbggEtqv1+kDORlh7/U
         wIC+nJCAetjhTQUxExtYz36VBk55sNSw+oz+QtTf7Y17+GzTzde74qhMqTa/v4XdPkxF
         h6KTtrPITkDuuAuKQ5R8CBO6KAfdp1k+jxM16DsBUsFyrCE8l+ihLyojg9Do24LDE6jo
         Ouo2GxlLbN/DFfHNsYdicqgyLVNa9xxA5rynAGf1sYnlhehBYJkmim+vXliZE3xghYXW
         56Tg==
X-Gm-Message-State: ANhLgQ2nzyPKIgojzKEbLZR7qp5FtXoeDHhJ3ysczJGUnC/3l1s/Dj0L
        s9ZM7v8+8BelhyooiTAfTco=
X-Google-Smtp-Source: ADFU+vu0lPLLkxTBDg3kdYLBZ1PHggNdsoXJGaPWHiSHH/SZyqqZbxTOnsAxk5Qvqg4dYMa8ztcWww==
X-Received: by 2002:a37:2794:: with SMTP id n142mr4814331qkn.336.1584451970138;
        Tue, 17 Mar 2020 06:32:50 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id m1sm2308396qtk.16.2020.03.17.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 06:32:49 -0700 (PDT)
Date:   Tue, 17 Mar 2020 09:32:45 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ezequiel@collabora.com,
        jbx6244@gmail.com, akash@openedev.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add Hugsun X99 IR receiver and
 power led
Message-ID: <20200317133245.GA1932@ubuntu>
References: <20200313230513.123049-1-npcomplete13@gmail.com>
 <7846021.K4VeDc98hx@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7846021.K4VeDc98hx@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 01:54:52AM +0100, Heiko Stuebner wrote:
> Am Samstag, 14. März 2020, 00:05:13 CET schrieb Vivek Unune:
> >  - Add Hugsun X99 IR receiver and power led
> >  - Remove pwm0 node as it interferes with power LED gpio
> >    pwm0 is not used in factory firmware as well
> > 
> > Tested with LibreElec linux-next-20200305
> > 
> > Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> 
> I've applied this for 5.7, but did split the patch into two.
> One for the addition of the IR and a second for led.
> 
> Please do similar for future patches.
> 
> Thanks
> Heiko
> 
> 

Hi Heiko,

Much appriciated. I'll make sure to do that with my future patches

Thanks,

Vivek
