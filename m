Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55652C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3217920825
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769916;
	bh=J7XeXrnf7EWLng0Ibi1VtPXm9pHCbnRQAorF/Vb5psk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=s1XD1ZDr77v1NmECR61JSOXN/KB/Lur6/1C6K+lni/l7tt9eRcitvffugU2oF1A24
	 URy64oGsK3RHHsajP+WAUz8mUaYCFl75rO2s4tQtNFjN2bWQpfMJr5rxG0tsk2s3IR
	 q/f2l559nVyWCumwn+B/GDLcE3n/DUh2Kqjxgk+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgHRQ6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgHRQ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:57:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6639C20825;
        Tue, 18 Aug 2020 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769844;
        bh=J7XeXrnf7EWLng0Ibi1VtPXm9pHCbnRQAorF/Vb5psk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uJtKoXYlAvw689386/D8cK4pqxSdmDWwlDLr4Toioy9PpWtmicYXPVzXBydgRfngY
         DpxvPNvZvk6Z2K0ex+YwjET96/sIdlqOwaUBxeP8BUVdjgg9Yb1SWUBIncDh98m7AT
         yItVFJjglJ7o9FM2UEv7onNJ5riYJ7mnKXqw4Xtk=
Date:   Tue, 18 Aug 2020 17:56:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20200803144436.5d2b7e54@xhacker.debian>
References: <20200803144436.5d2b7e54@xhacker.debian>
Subject: Re: [PATCH v3] dt-bindings: regulator: Convert sy8824x to json-schema
Message-Id: <159776976828.56451.12856424120296708687.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 14:44:36 +0800, Jisheng Zhang wrote:
> Convert the sy8824x binding to DT schema format using json-schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Convert sy8824x to json-schema
      commit: aedf7451e7535bc93bb9cec0ebc91744934da95c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
