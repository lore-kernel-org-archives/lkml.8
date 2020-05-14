Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2CCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7ABA206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgENGyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:54:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:7541 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgENGyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:54:20 -0400
IronPort-SDR: 535MA8ZtMIyBUW8vsjtnyrkCsLFKvd83ypr1HKa4W+h6d3+Xl40iJNFMcBL2CHKwBznJug7GcX
 FF6UPMTtTh3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:54:19 -0700
IronPort-SDR: nkEHClJUy5EN+12cO0GzcE+PG208sms75zq0FJ0TdmRIzrrgwGUM96plY7ZyhTWvdnE0t9cXYq
 m6AAfNnjSqPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="372145228"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 May 2020 23:54:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 14 May 2020 09:54:15 +0300
Date:   Thu, 14 May 2020 09:54:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200514065415.GA1511@kuha.fi.intel.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <CAFd5g44d+VCSimjboPkf-NF1eCdbq6Uy+pabNftB8p5Lj2yc1A@mail.gmail.com>
 <e51d4ce4-42ba-8c89-21b4-082c7158a9a9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51d4ce4-42ba-8c89-21b4-082c7158a9a9@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 04:14:51PM -0700, Randy Dunlap wrote:
> On 5/13/20 2:30 PM, Brendan Higgins wrote:
> > On Wed, May 13, 2020 at 8:18 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> >>
> >> In the function kobject_cleanup(), kobject_del(kobj) is
> >> called before the kobj->release(). That makes it possible to
> >> release the parent of the kobject before the kobject itself.
> >>
> >> To fix that, adding function __kboject_del() that does
> >> everything that kobject_del() does except release the parent
> >> reference. kobject_cleanup() then calls __kobject_del()
> >> instead of kobject_del(), and separately decrements the
> >> reference count of the parent kobject after kobj->release()
> >> has been called.
> >>
> >> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> >> Cc: Brendan Higgins <brendanhiggins@google.com>
> >> Cc: Randy Dunlap <rdunlap@infradead.org>
> >> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > 
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks guys. Sorry about the mix-up.

Br,

-- 
heikki
