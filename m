Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B848C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260D520706
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHWQE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:04:56 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:55286 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726502AbgHWQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 12:04:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id AD30118224D9C;
        Sun, 23 Aug 2020 16:04:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dirt18_190ae292704b
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Aug 2020 16:04:52 +0000 (UTC)
Message-ID: <a6fb2b6dcabb7cfd59b16a6fa1b4c49bbc73bb8f.camel@perches.com>
Subject: Re: [PATCH] hugetlb_cgroup: convert comma to semicolon
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xu Wang <vulab@iscas.ac.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Date:   Sun, 23 Aug 2020 09:04:51 -0700
In-Reply-To: <20200823152130.GA17456@casper.infradead.org>
References: <20200818064333.21759-1-vulab@iscas.ac.cn>
         <20200818184036.d6c479446b2c3b231d1e3bff@linux-foundation.org>
         <87eeo32gto.fsf@redhat.com> <20200823152130.GA17456@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-23 at 16:21 +0100, Matthew Wilcox wrote:
> On Wed, Aug 19, 2020 at 10:14:11AM +0200, Giuseppe Scrivano wrote:
> > > > -	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]),
> > > > +	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
> > > >  	cft->flags = CFTYPE_NOT_ON_ROOT;
> > 
> > I think in this case having two expressions as part of the same
> > statement is equivalent to having two separate statements.  Both
> > cft->file_offset and cft->flags get the expected value.
> 
> That's not how the comma operator works.
> 
> It will evaluate offsetof(struct hugetlb_cgroup, events_file[idx]) and
> then discard the result.  Since it has no side-effects, this is effectively
> doing:
> 
> 	cft->file_offset = cft->flags = CFTYPE_NOT_ON_ROOT;

$ gcc -x c -
#include <stdio.h>
#include <stdlib.h>

struct foo {
	int a;
	char b[50];
};

int main(int argc, char **argv)
{
	int a;
	int b;

	a = sizeof(struct foo), b = 1;

	printf("a: %d, b: %d\n", a, b);

	return 0;
}
$ ./a.out
a: 56, b: 1


