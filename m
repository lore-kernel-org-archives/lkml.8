Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183D720758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHQIH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:07:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:4979 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgHQIH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:07:26 -0400
IronPort-SDR: g8VbzN/3k8gkn+U8de9XFeyrvQNgA8AYHCnjm5HExa4oqR7uiqdEpF/kqsGz+UEDOCbZY/Sxm4
 PtbFqJCAbOqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134714646"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="134714646"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 01:07:26 -0700
IronPort-SDR: UprZgQpDHZHN14fzFVEaiHymPDrfMsQnr0c7TfR/wV0ycE/rljC7OUHhOmc9FZ24iLIM0W/Jtw
 fNMHYcNHnY+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="400121917"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Aug 2020 01:07:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 Aug 2020 11:07:23 +0300
Date:   Mon, 17 Aug 2020 11:07:23 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v3] tcpm: During PR_SWAP, source caps should be sent
 only after tSwapSourceStart
Message-ID: <20200817080723.GB1448906@kuha.fi.intel.com>
References: <20200812022934.568134-1-badhri@google.com>
 <20200813082507.GE1169992@kuha.fi.intel.com>
 <CAPTae5KUdTN5fVn45xFwhWS5Gy_xFJ91gAObb7qMk2KA+n72yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5KUdTN5fVn45xFwhWS5Gy_xFJ91gAObb7qMk2KA+n72yQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:40:04PM -0700, Badhri Jagan Sridharan wrote:
> Hi Heikki,
> 
> Sure. Same as the other patch I will try to address your question here
> and will update the commit description once you are satisfied with the
> description.
> 
> Subject:
> During PR_SWAP, source caps should be sent only after tSwapSourceStart
> 
> Commit description:
> The patch addresses the compliance test failures while running
> TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 of the "Deterministic PD
> Compliance MOI" test plan published in https://www.usb.org/usbc.
> For a product to be Type-C compliant, it's expected that these tests
> are run on usb.org certified Type-C compliance tester as mentioned in
> https://www.usb.org/usbc.
> 
> The purpose of the tests TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 is to
> verify the PR_SWAP response of the device. While doing so, the test
> asserts that Source Capabilities message is NOT received from the test
> device within tSwapSourceStart min (20 ms) from the time the last bit
> of GoodCRC corresponding to the RS_RDY message sent by the UUT was
> sent. If it does then the test fails.
> 
> This is in line with the requirements from the USB Power Delivery
> Specification Revision 3.0, Version 1.2:
> "6.6.8.1 SwapSourceStartTimer
> The SwapSourceStartTimer Shall be used by the new Source, after a
> Power Role Swap or Fast Role Swap, to ensure that it does not send
> Source_Capabilities Message before the new Sink is ready to receive
> the
> Source_Capabilities Message. The new Source Shall Not send the
> Source_Capabilities Message earlier than tSwapSourceStart after the
> last bit of the EOP of GoodCRC Message sent in response to the PS_RDY
> Message sent by the new Source indicating that its power supply is
> ready."
> 
> The patch makes sure that TCPM does not send the Source_Capabilities
> Message within tSwapSourceStart(20ms) by transitioning into
> SRC_STARTUP only after  tSwapSourceStart(20ms).

That looks good to me. Thanks.

Br,

-- 
heikki
