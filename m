Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E45DC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13132206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgBLPxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:53:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:37261 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBLPxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:53:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 07:53:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="347535140"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 07:53:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 12 Feb 2020 17:53:09 +0200
Date:   Wed, 12 Feb 2020 17:53:09 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        heikki.krogerus@intel.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add cros-ec Type C port driver
Message-ID: <20200212155309.GG1498@kuha.fi.intel.com>
References: <20200207203752.209296-1-pmalani@chromium.org>
 <20200207203752.209296-2-pmalani@chromium.org>
 <CAL_JsqKnQDhnb14TsOeHhXS0UAX6kexe44pfOntrbEcxB0CC9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKnQDhnb14TsOeHhXS0UAX6kexe44pfOntrbEcxB0CC9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Feb 11, 2020 at 05:25:13PM -0600, Rob Herring wrote:
> > +examples:
> > +  - |+
> > +    typec {
> > +      compatible = "google,cros-ec-typec";
> > +
> > +      port@0 {
> 
> 'port' is reserved for OF graph binding which this is not.
> 
> > +        port-number = <0>;
> > +        power-role = "dual";
> > +        data-role = "dual";
> > +        try-power-role = "source";
> 
> These are usb-connector binding properties, but this is not a
> usb-connector node. However, I think it should be. The main thing to
> work out seems to be have multiple connectors.
> 
> With your binding, how does one associate the USB host controller with
> each port/connector? That's a solved problem with the connector
> binding.

It looks like OF graph is required to be used for that. The plan was
actually to propose that we use device properties "usb2-port" and
"usb3-port" that directly reference the port nodes under the USB host
controller, but I guess that's too late for that.

OF graph creates one problem. We are going to need to identify the
endpoints somehow in the USB Type-C drivers, so how do we know which
endpoint is for example the USB2 port, which is USB3, which is
DisplayPort, etc?

Does the remote-endpoint parent need to have a specific compatible
property, like the USB2 port needs to have compatible = "usb2-port"
and so on?

thanks,

-- 
heikki
