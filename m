Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F15C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DAA20736
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEHOBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:01:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:21312 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgEHOBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:01:40 -0400
IronPort-SDR: uzSvTKMEUVJMbzS4wGjf5EcyMp5i5ejLkOD9Z6qI6qtfYtelYxjtqwP+73Uci8PwRsGaevyrui
 1H5kf/ppO/Tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 07:01:39 -0700
IronPort-SDR: tyLSI9pNoX+sLzweinsTc8kCksLLnDn7G53YEFJasLjS/iKAb/GKJhocYPyIJt0XH8Fc8BDKqF
 y9O2NhzHgJnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="370495411"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 May 2020 07:01:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 May 2020 17:01:32 +0300
Date:   Fri, 8 May 2020 17:01:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Angus Ainslie <angus@akkea.ca>
Cc:     robh+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org
Subject: Re: [PATCH v2 0/2] Add TI tps6598x DT binding and probe
Message-ID: <20200508140132.GA1264047@kuha.fi.intel.com>
References: <20200507214733.1982696-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507214733.1982696-1-bryan.odonoghue@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 07, 2020 at 10:47:31PM +0100, Bryan O'Donoghue wrote:
> V2:
> - Put myself down as sole schema maintainer as suggested - Andy
> - Fixed whitespace typo - Andy
> - Removed ifdef and of_match_ptr() - Andy
> 
> V1:
> This simple series adds DT binding yaml and a DT lookup table for the
> tps6598x.
> 
> Its possible to use i2c id_table to match the 'compatible = "ti,tps6598x"
> and probe that way, however I think it is worthwhile adding a specific OF
> way of doing it and having an accompanying yaml as an example.
> 
> Bryan O'Donoghue (2):
>   dt-bindings: usb: Add TI tps6598x device tree binding documentation
>   usb: typec: tps6598x: Add OF probe binding
> 
>  .../devicetree/bindings/usb/ti,tps6598x.yaml  | 64 +++++++++++++++++++
>  drivers/usb/typec/tps6598x.c                  |  7 ++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml

There was already a series from Angus [1] for this. The bindings
looked a bit different, but I think we should use these, because in
the DT bindings from Angus there appeared to be definitions for OF
graph that was not used. Or maybe I got it wrong?

Angus, is it OK if we use these patches instead the ones from you?

[1] https://lore.kernel.org/linux-usb/20200506191718.2144752-1-angus@akkea.ca/

thanks,

-- 
heikki
