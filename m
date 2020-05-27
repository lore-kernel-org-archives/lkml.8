Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B4FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE673207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590545625;
	bh=e4SRdX/Xhjrj8dyEI2uQ+w+OwV4n+PH5ccpVE47KkU8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=RNN/zzAscEntiCB3hgot6O7bSwATfZrBiswCZmP5VhULgfAV5NEnaOnV67Dm4upU/
	 CQtuxtodnEwRoWG7ROjYGSpMnU6KLAWHnyyip71Ki65qQATcxs7YC4v8+YRLf1hkF5
	 8MyTYS4g9CqB1Ts+ndprd8iQDpGBkt2mx+QNUoNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgE0CNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgE0CNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:13:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9268C2075F;
        Wed, 27 May 2020 02:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590545622;
        bh=e4SRdX/Xhjrj8dyEI2uQ+w+OwV4n+PH5ccpVE47KkU8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cH2XS94dokx+dvlxGYpliVpYZAvl92AUAM5StdOEpeoEI+QAZT4RZiUZGI71LA1KA
         sWVm5lL6osodvJ6nvxNTA5gxVikUAuWQTMPbXRf2eRCioWAiGttPLj4+vsuoU/1uwH
         xSjiK7H8FmIx8VOYolhLMbZep8bEK4gtYdE5iXqg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200512181647.5071-4-dinguyen@kernel.org>
References: <20200512181647.5071-1-dinguyen@kernel.org> <20200512181647.5071-4-dinguyen@kernel.org>
Subject: Re: [RESEND PATCHv7 4/5] dt-bindings: documentation: add clock bindings information for Agilex
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
Date:   Tue, 26 May 2020 19:13:41 -0700
Message-ID: <159054562195.88029.4829686635678975593@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2020-05-12 11:16:46)
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Agilex
> platform.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
