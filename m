Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F92C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FCB2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="U25wmsLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbgDBGpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:45:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39248 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgDBGpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:45:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id h6so1765808lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EZyuiVnozfn4q8862+HLJ5Fa1ZANzh/YxUt+8Dn90Cw=;
        b=U25wmsLnITOsDRVSjieHY9ctvRnpEZfY0UMZLiLcHNxLqyYAprfEgdE24OBiZ4BjNn
         ia4VyvVImgmkhtXBuu4KVGFh/OejLtg6ndEb9r6VoSxGrlzt8Y+DnH9tVOgYooW4ON/Z
         WWXDh0JXA0RVMCb3u8lxA4wji7yt+Aq7/zTn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EZyuiVnozfn4q8862+HLJ5Fa1ZANzh/YxUt+8Dn90Cw=;
        b=PwI1ppJP0/8vWI+gPyPQpK2WSrCu5DRUzSBS/acSE/p40/SisnDVLvg/e0mKSo0V0Q
         H7xLkA7tvLtIGTnyJKYUtyJG4sOv32cVIMmuYRDQjGNg4kBZTzjGyjGXCA/nzlUpEMTV
         y4mN74chGJDy+dfzVAkIxb9gEhrSHYUT0srVbjX1Dq24bCcJew2ZBekzS1g5Wa1lLfqQ
         IpWbnVY6RmazFY5nhVS0RJVLy71JXm9CUH8R0oTppVpG13wZxTqLqCLTjXqxNLAOBSpQ
         13veTV1WzikhEOnlSl+66e7XtZsebcfTjCtpjLIfkY2H/80CMwvqdK6h2SYF8UFYQnew
         QZ1A==
X-Gm-Message-State: AGi0PuZdVC0KapVyZsL2NhzpeUQc8x16PLX3hGUG+XY+5Yl75tTJ8SCU
        xGJrAtLrd1EwFzQozaJ16x2LQA==
X-Google-Smtp-Source: APiQypLVw29BfEQm2ylpYaYjCZ3N3s2Ld+g6aDIGQPJg9N768dBIDwpn94ed4SkR+xDdxF/ShVWhHw==
X-Received: by 2002:a19:f017:: with SMTP id p23mr1178977lfc.150.1585809932026;
        Wed, 01 Apr 2020 23:45:32 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id m12sm2530439lji.50.2020.04.01.23.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:45:31 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:45:26 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200402084513.4173306-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for LiteX SoC Controller
and LiteUART - serial device from LiteX SoC builder
(https://github.com/enjoy-digital/litex).

In the following patchset I will add
a new mor1kx-based (OpenRISC) platform that
uses this device.

Later I plan to extend this platform by
adding support for more devices from LiteX suite.

Changes in v4:
    - fixed copyright headers
    - fixed SoC Controller's yaml
    - simplified SoC Controller's driver

Changes in v3:
    - added Acked-by and Reviewed-by tags
    - introduced LiteX SoC Controller driver
    - removed endianness detection (handled now by LiteX SoC Controller driver)
    - modified litex.h header
    - DTS aliases for LiteUART made optional
    - renamed SERIAL_LITEUART_NR_PORTS to SERIAL_LITEUART_MAX_PORTS
    - changed PORT_LITEUART from 122 to 123

Changes in v2:
    - binding description rewritten to a yaml schema file
    - added litex.h header with common register access functions

Filip Kokosinski (3):
  dt-bindings: vendor: add vendor prefix for LiteX
  dt-bindings: serial: document LiteUART bindings
  drivers/tty/serial: add LiteUART driver

Pawel Czarnecki (2):
  dt-bindings: soc: document LiteX SoC Controller bindings
  drivers/soc/litex: add LiteX SoC Controller driver

 .../bindings/serial/litex,liteuart.yaml       |  38 ++
 .../soc/litex/litex,soc-controller.yaml       |  39 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/litex/Kconfig                     |  14 +
 drivers/soc/litex/Makefile                    |   3 +
 drivers/soc/litex/litex_soc_ctrl.c            | 217 +++++++++
 drivers/tty/serial/Kconfig                    |  32 +-
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 411 ++++++++++++++++++
 include/linux/litex.h                         |  45 ++
 include/uapi/linux/serial_core.h              |   3 +
 14 files changed, 815 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1

