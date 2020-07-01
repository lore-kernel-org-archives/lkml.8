Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF71C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EDB207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C71K5/fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgGAPTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731511AbgGAPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:19:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD94C08C5C1;
        Wed,  1 Jul 2020 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=RMq+iE1LUPENeNcgBeF0Dm87bPYKtg4gXNNVgu26xNQ=; b=C71K5/fQGisGL/dr162sd1/BB0
        PKXUXMzoOs1afRIhld7BQ9X7Pr4/y1MLjs8gQLGV98nh88bgZ+pw2CnwPL2I6DoGrBt4SfCuJAAAG
        Pbceya8bm8et3ppzsfP50Wvq/oYOsVgqyFo5BK1gm47jR1/SeiqtHL7E1uSIqRP3ol+8eUm2K8jaV
        RcKZR8XfcKONRxcIRVyd6WaPpfjCHJRSvjxe+UkOETlAlE2laAv2k9yPX0dwWOM0YC83jwEnr2My/
        PkNAvhmO2EZhzSFBzyX2BrWqufyNegvBKJWrUEHfZ2RFpKKcNJ+nDVl4U7AsHWZD66vIjR/cTDZm9
        14ntrsQg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqeWF-00086O-TU; Wed, 01 Jul 2020 15:19:28 +0000
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
Date:   Wed, 1 Jul 2020 08:19:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 8:15 AM, Markus Elfring wrote:
>>> Would you like to integrate any more details from the running patch review?
>>
>> I am satisfied with the current patch.
> 
> I got an other software development impression.
> 
> 
>> No doubt that any documentation can be improved, almost ad infinitum,
>> but I'm not trying to do that.
> 
> Do we stumble on a target conflict according to a specific technical detail?
> 
> How do you think about to compare source code analysis results
> from programs like “sparse” and “spatch” (by the mentioned make command)?

None of that has anything to do with the current patch.

Julia, do you have any comments about the current patch? (v2)

thanks.

-- 
~Randy

