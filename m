Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC6AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732E020658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHLTbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:31:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:40508 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHLTbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:31:10 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 07CJUX3N023473;
        Wed, 12 Aug 2020 14:30:33 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 07CJUWOw023470;
        Wed, 12 Aug 2020 14:30:32 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 12 Aug 2020 14:30:32 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()
Message-ID: <20200812193032.GU6753@gate.crashing.org>
References: <c2addbd9d76212242d3d8554a2f7ff849fb08b85.1587040754.git.christophe.leroy@c-s.fr> <7b916759-1683-b4df-0d4b-b04b3fcd9a02@csgroup.eu> <878sg6862r.fsf@mpe.ellerman.id.au> <875zb98i5a.fsf@mpe.ellerman.id.au> <8b751738-a9d1-8f55-8f9b-9264c8ac7ed8@csgroup.eu> <faa6759a-8188-104b-a9f9-a5ff3b060cfa@csgroup.eu> <c827fd9b-984d-ca86-67e9-512ca10d118f@csgroup.eu> <0b63e2b8-a134-9a50-2106-8ff110cf9a31@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b63e2b8-a134-9a50-2106-8ff110cf9a31@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:32:51PM +0200, Christophe Leroy wrote:
> Anyway, it seems that GCC doesn't make much use of the "m<>" and the 
> pre-update form.

GCC does not use update form outside of inner loops much.  Did you
expect anything else?

> Most of the benefit of flexible addressing seems to be 
> achieved with patch 1 ie without the "m<>" constraint and update form.

Yes.


Segher
