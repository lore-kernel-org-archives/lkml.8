Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8925AC18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5814224671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="bqdRmzWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQqd9C5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBSU1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:27:01 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33885 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgBSU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:27:00 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BB9121CDD;
        Wed, 19 Feb 2020 15:27:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 19 Feb 2020 15:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=BCiszm3J14KQfjxnnfw1+Ey2sCy
        jWRIL//3yqk0MnCc=; b=bqdRmzWo1wSa8Hf/44q+Le0vp4MsXfrohD43+/tQrQE
        9tNOvWnmEzfpKVjc0KA8uZih74Uuyd0y5V6ywnPGuqVqgM3x/8S35CJ63IfI0Xgv
        LhKwp03V/CQ0rXTgvBq2ZRztlHspPxud16fMqymVrEzHoSbWkTX/vIp2bgRhI2zg
        i2Zjrd7hOC/H5cmlo8Ciew686TxafvveJmUXJ2evlfwIc49U3Hhgvuxgn2EXxB3+
        6H+pt5kPuCC0Vb95srwRcQFwGDBp7DfzWLzOX2RANDurISyiL5C7/tdwrou+w0mX
        eYHcQP3rJQKUIfZLGzEFrX0MLEJz+LHrhgFGNhb4+9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BCiszm
        3J14KQfjxnnfw1+Ey2sCyjWRIL//3yqk0MnCc=; b=BQqd9C5lkHd+HQ/HQmdGBm
        5iAdWHJr+65m9JXRuOA+7YAKbhkVUj1Gpvy/NyEls9QyZ8MhS6r7+vUfIfoXBFSA
        FsBoZtxKJ4Cpj9mc47K+wR/ILutkZk9AzKdbBPA4E8Murw22+ZyLQC/e0uNVCe74
        DHakwaM8oMrlxn8ltf1Vs8MTM39lKPWw5Nv1ZgHAbGn3lQFIi0zhXmuHMYEjn/5v
        lCOgmYOv3HayGBZcC1xE5DfleyYiD0vFqhhaaf0XWzUimwCbnNz3+YehJi4qDbrn
        L37yLOTgN1jOXFtm1PEyMHAKeOHkHxrPQVcIhq6DEiBJ0hX60Aof6ngsWXoiopqg
        ==
X-ME-Sender: <xms:E5pNXmpjqdGK9SHQf0IJr5Jjx1xzLJmlHxSHorbhQbJSIMghvuhK-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedtgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppedvvddtrddvfeehrddukedurddujeelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttg
X-ME-Proxy: <xmx:E5pNXp8wJK6og6F7yEpleU29A--f9NwFNNfnhNIz4bQGDAdnkT2zGw>
    <xmx:E5pNXrGeJcMOZPn3wew-nOBbpg2sCNMD5fqJJWWhY0udvN96ZFd4fA>
    <xmx:E5pNXl7jBTIa9U3i95iJ66SXr-AVo7U0KPFY8B6fUZL34wn8PU--xQ>
    <xmx:FJpNXm7h-_abpi_z97MFgtYtms9Ic7uICrO_io8DaO19ZiCZXXMPvA>
Received: from localhost (220-235-181-179.dyn.iinet.net.au [220.235.181.179])
        by mail.messagingengine.com (Postfix) with ESMTPA id B2B363280060;
        Wed, 19 Feb 2020 15:26:58 -0500 (EST)
Date:   Thu, 20 Feb 2020 07:26:55 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tools: vm: slabinfo: Add numa information for objects
Message-ID: <20200219202655.GA5319@ares>
References: <20200217084828.9092-1-tobin@kernel.org>
 <20200217084828.9092-3-tobin@kernel.org>
 <alpine.DEB.2.21.2002181623150.20682@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002181623150.20682@www.lameter.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:24:54PM +0000, Christopher Lameter wrote:
> On Mon, 17 Feb 2020, Tobin C. Harding wrote:
> 
> > Add a field to the slabinfo struct for the NUMA information and
> > output it during a NUMA report as is done for `slabs` and `partial`.
> 
> How will this look? Note that there are boxes now with potentially huge
> NUMA nodes (AMD Rome can already do 32 with an optimal BIOS layout for
> minimal latency).
> 
> Maybe make it optional with a --numa switch or so?


Cool, can do.  Thanks for the review.

	Tobin
