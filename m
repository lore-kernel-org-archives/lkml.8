Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB48C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFA9206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEUkJEGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgF3UZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgF3UZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:25:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C24C061755;
        Tue, 30 Jun 2020 13:25:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so21896375ejb.11;
        Tue, 30 Jun 2020 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=3BVg2c+iZJ6BUBSCd+wJqnaJSQM6YxHesQQZvEY+piQ=;
        b=qEUkJEGGYrkC+/Z5OxodNQEc64G1Ld/5FVORp39W3p7SX7rS8vvvIvHNDrMbHWyTjv
         IlQaQhu0GbjZNwBCycKG0MgO3arlxdEqHD1aFy+WLdTWh117RfS7g/hDv4WHgwtmXL+v
         Cz+rxC2kp8na3SmkYeKvxx86yqZ7tV8oTarb9L4uifJfDE/yPquduDf0J5UEzmO9+XVG
         NrHE3Gk2P9xDa3Mxf6HUvWGJuPdXp0uVBLuKi6Kq4v7PxAcJcsCkyMZl3QypopoFXqhO
         rEoTnaDGV1AbIOeELk8zybp8lurmXf1JlJ93DSK0Y8wV3E+BA/PPCpgK6R3ZayyjQl+M
         0tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=3BVg2c+iZJ6BUBSCd+wJqnaJSQM6YxHesQQZvEY+piQ=;
        b=OTGjcA0zUZfQ48dMXB78tDGSN5OScUK5qhEs3M8nNLnkKXSM4ZEBrj3CO6eekJgoUP
         9imeF+bBfr8NGbD3zHR/zsYQOoHJil5/Hzulfp7enhGN4qhsey2xWC0tJlyy2651xHQ+
         o/46qZPA5RPV+NKvQDQ1bRMMOo9TvTwIZyRv9c6w5dB6vMRybUqmRuoTqZrtQt1loQ/v
         fw71bxPhr1wb67mJ3+CObIw5zrFWIgfB41RjlyNzqaWwR7jwucRHsIZ4xr7CdNlxULFp
         mr+cKpktE9YLbYSK33pjp6YcI5om1PrvecjrLmwHaJxW85BT5GIoqo7lDLppswBLbRos
         WwzA==
X-Gm-Message-State: AOAM531Q+Pf2sMx3myi7I+sB0WpR1TVnhWBtb8C0Qmp6MICu9GuAwA5h
        ao95XXvKCF+pkqNh2nv/kucJlB9PZ1DLdg==
X-Google-Smtp-Source: ABdhPJwueQ5FQ8JHUBqFoS3BbyZpSxDPjnNRkPgWqTNqTSI/grdE8JVpKA3f40vbNt5AO8DGfbThwA==
X-Received: by 2002:a17:906:375a:: with SMTP id e26mr20546470ejc.324.1593548740521;
        Tue, 30 Jun 2020 13:25:40 -0700 (PDT)
Received: from felia ([2001:16b8:2d31:bc00:cc6f:aee9:d326:7bf7])
        by smtp.gmail.com with ESMTPSA id ay27sm4004007edb.81.2020.06.30.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:25:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 30 Jun 2020 22:25:31 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>
cc:     Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Status of MAINTAINERS clean-up
Message-ID: <alpine.DEB.2.21.2006302214290.4085@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

as Ralf Ramsauer and Pia Eichinger coincidently picked up and worked on 
the same MAINTAINERS clean-up task, Ralf requested to get a quick report 
on the state of the MAINTAINERS clean-up. Here you go.

I regularly run ./scripts/get_maintainers.pl ./scripts/get_maintainer.pl 
--self-test=patterns on Linus' tree and linux-next, address the issues and 
send out minor patches or simply report to the committers after a basic 
analysis.

Currently on v5.8-rc3, we have 17 warnings. On next-20200629, we have 16 
warnings with some overlap with the v5.8-rc3 warnings.

In more detail, here are all findings, put into categories and grouped 
when addressed with one patch.


WARNING ON v5.8-rc3, ADDRESSED IN next-20200629

./MAINTAINERS:3949: warning: no file matches	F:	Documentation/devicetree/bindings/rng/arm-cctrng.txt
./MAINTAINERS:5493: warning: no file matches	F:	Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
./MAINTAINERS:14577: warning: no file matches	F:	Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
./MAINTAINERS:14578: warning: no file matches	F:	Documentation/devicetree/bindings/thermal/rcar-thermal.txt

No further action required.


WARNING ON v5.8-rc3 AND next-20200629, PATCH PENDING


[PATCH] MAINTAINERS: rectify entry in ARM SMC WATCHDOG DRIVER
./MAINTAINERS:1492: warning: no file matches	F:	devicetree/bindings/watchdog/arm-smc-wdt.yaml
    Pending Patch: https://lore.kernel.org/linux-watchdog/20200602052104.7795-1-lukas.bulwahn@gmail.com/


[PATCH v2 RESEND] MAINTAINERS: rectify MMP SUPPORT after moving cputype.h
./MAINTAINERS:11487: warning: no file matches	F:	linux/soc/mmp/
    Pending Patch: https://lore.kernel.org/lkml/20200506053431.7464-1-lukas.bulwahn@gmail.com/


[PATCH SECOND RESEND] MAINTAINERS: adjust entries to moving CEC platform drivers
./MAINTAINERS:2410: warning: no file matches	F:	drivers/media/platform/s5p-cec/
./MAINTAINERS:2555: warning: no file matches	F:	drivers/media/platform/tegra-cec/
./MAINTAINERS:3976: warning: no file matches	F:	drivers/media/platform/cec-gpio/
./MAINTAINERS:11155: warning: no file matches	F:	drivers/media/platform/meson/ao-cec-g12a.c
./MAINTAINERS:11156: warning: no file matches	F:	drivers/media/platform/meson/ao-cec.c
./MAINTAINERS:15266: warning: no file matches	F:	drivers/media/platform/seco-cec/seco-cec.c
./MAINTAINERS:15267: warning: no file matches	F:	drivers/media/platform/seco-cec/seco-cec.h
./MAINTAINERS:16305: warning: no file matches	F:	drivers/media/platform/sti/cec/
    Pending Patch: https://lore.kernel.org/lkml/20200525142946.8268-1-lukas.bulwahn@gmail.com/


WARNING ON v5.8-rc3 AND next-20200629, UNADDRESSED


./MAINTAINERS:11457: warning: no file matches	F:	drivers/*/*/*loongson2*
./MAINTAINERS:11467: warning: no file matches	F:	drivers/*/*/*loongson3*
./MAINTAINERS:11468: warning: no file matches	F:	drivers/*/*loongson3*

I had a first look, it is a special case, the committer wants to be 
informed on all loongson{2,3} files in drivers, but really in the last 
two years, there is only one directory that appeared in the repository 
and matched these patterns. So, one could probably just settle for naming 
the file that is in the repository right now. I did not send a patch yet, 
though.


WARNING ONLY ON next-20200629, PATCH ACCEPTED


[PATCH] MAINTAINERS: remove obsolete entry after file renaming
./MAINTAINERS:5024: warning: no file matches	F:	drivers/regulator/da903x.c
    Accepted Patch: https://lore.kernel.org/lkml/20200628180229.5068-1-lukas.bulwahn@gmail.com/

No further action required.


WARNING ONLY ON next-20200629, ADDRESSED DIFFERENTLY


./MAINTAINERS:6874: warning: no file matches	F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
    Warning just appeared recently, warnings on 
Documentation/devicetree/bindings/ are usually addressed by devicetree 
maintainers before the pull request. So, no action required for now.


./MAINTAINERS:14057: warning: no file matches	F:	Documentation/networking/device_drivers/ethernet/qlogic/LICENSE.qla3xxx
    Appeared with a recent commit of moving files in Documentation.

    The real clean-up task for that file is described here: 
https://lore.kernel.org/linux-spdx/alpine.DEB.2.21.2006300644130.4919@felia/


SUMMARY

At the moment, I do not see too much potential for others to really  
contribute to this specific clean-up. Once the pending patches are picked 
up, which is tricky part, i.e., resubmitting and reminding, there have 
been so far not too many new warnings appearing, and the warnings on .txt 
to .yaml conversions in Documentation/devicetree/bindings/ are usually  
followed up by some devicetree maintainers and janitors.


Other MAINTAINERS clean up topics, I see on a longer task list are:

  - Go through the L: entries and address, "lists" that are 'email 
forwarders', but not (public) mailing lists with archives.
    Current idea is to either mark them special or make them M: or R: 
entries.

  - Assigning files to the "right" sections, not just having them lay 
around in THE REST. This will be lots of manual work and needs some kind 
of script-assisted approach, as many files are headers in include.

  - Documenting the properties for a clean MAINTAINERS file and the 
available checkers and tools

Contribution to those tasks are welcome, but they are by no means quick 
and easy fixes. They will need some thought and lots of persistence and 
patience to get done.


Lukas
