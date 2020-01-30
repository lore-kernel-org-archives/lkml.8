Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF557C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB558206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgA3RGc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:06:32 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:59262 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3RGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:06:31 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 7B0BB1B0DC; Thu, 30 Jan 2020 17:06:29 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH 1/2] dt-bindings: usb: add non-removable-ports hub property
References: <20200124152504.23411-1-mans@mansr.com>
        <20200127153506.GA4589@bogus> <yw1xy2tsvnww.fsf@mansr.com>
        <20200128134745.GA3048749@kroah.com> <yw1xpnf3vchs.fsf@mansr.com>
        <20200128152818.GB3437093@kroah.com>
        <20200128165243.GC3666045@kroah.com>
        <CAL_JsqK1fMCrbbMdRPqVjtS0D6p4AhqjcOGoivGbT2aKN7UJWw@mail.gmail.com>
Date:   Thu, 30 Jan 2020 17:06:29 +0000
In-Reply-To: <CAL_JsqK1fMCrbbMdRPqVjtS0D6p4AhqjcOGoivGbT2aKN7UJWw@mail.gmail.com>
        (Rob Herring's message of "Tue, 28 Jan 2020 12:21:32 -0600")
Message-ID: <yw1ximksvppm.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> n Tue, Jan 28, 2020 at 10:52 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Jan 28, 2020 at 04:28:18PM +0100, Greg Kroah-Hartman wrote:
>> > On Tue, Jan 28, 2020 at 03:15:11PM +0000, Måns Rullgård wrote:
>> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> > >
>> > > > On Mon, Jan 27, 2020 at 04:56:15PM +0000, Måns Rullgård wrote:
>> > > >> Rob Herring <robh@kernel.org> writes:
>> > > >>
>> > > >> > On Fri, Jan 24, 2020 at 03:25:03PM +0000, Mans Rullgard wrote:
>> > > >> >> Add a non-removable-ports property that lists the hardwired downstream
>> > > >> >> ports of a hub.  Although hubs can provide this information, they are
>> > > >> >> not always configured correctly.  An alternate means of indicating this
>> > > >> >> for built-in USB devices is thus useful.
>> > > >> >>
>> > > >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> > > >> >
>> > > >> > I reviewed this already, but since you didn't add my reviewed-by, I'm
>> > > >> > looking at it again and having 2nd thoughts.
>> > > >> >
>> > > >> >> ---
>> > > >> >>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
>> > > >> >>  1 file changed, 4 insertions(+)
>> > > >> >>
>> > > >> >> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
>> > > >> >> index 036be172b1ae..92d863cc96b6 100644
>> > > >> >> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
>> > > >> >> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
>> > > >> >> @@ -66,6 +66,10 @@ Required properties for host-controller nodes with device nodes:
>> > > >> >>  - #size-cells: shall be 0
>> > > >> >>
>> > > >> >>
>> > > >> >> +Optional properties for hub and host-controller nodes:
>> > > >> >> +- non-removable-ports: list of hardwired downstream ports
>> > > >> >
>> > > >> > If you have a hardwired device and need to know that, doesn't that imply
>> > > >> > there's some other stuff you need to describe beyond what a standard USB
>> > > >> > device has. Such as a power supply that's not Vbus from the hub.
>> > > >>
>> > > >> I suppose there could be, but there isn't in my actual situation.
>> > > >>
>> > > >> > At a minimum, I think this should be a per port property.
>> > > >>
>> > > >> That's what I suggested first.  Greg told me to do it like this instead.
>> > > >
>> > > > I said that?  I do not remember discussing this at all, when did that
>> > > > happen?
>> > >
>> > > https://lore.kernel.org/lkml/20190228155241.GC12050@kroah.com/
>> >
>> > Almost a full year ago!  Hah, I can't remember what I wrote last week.
>>
>> Ah, ok, all I said was "do what ACPI does here", as that's a model of
>> what has already been agreed apon by a whole huge number of people and
>> standardized.  No need for DT to come up with something totally
>> different instead, making a mess of things :)
>>
>> If this is doing what ACPI does, fine, if not, it should.  It was here
>> first.
>
> That's not always possible as ACPI and DT work in different ways. The
> DT (Open Firmware) USB binding originated in 1998[1]. While ancient,
> that is what defines the node structure of USB hubs, ports, and
> devices that we use today.
>
> However, after a quick read of ACPI sec 9.14, I'd say what I suggested
> is more aligned to ACPI than what's proposed here. Ports are child
> nodes ("Device" in ACPI terms) and the properties to determine all
> this are properties of the port node(s). Aligning beyond that isn't
> really possible. ACPI has a standard thing (not sure what the proper
> term is) called '_PLD' for describing device location which includes
> 'user visible' among several other things. There is no such concept in
> DT to align with. What we have is the 'non-removable' property and IMO
> that's what we should use here.

Can you guys please agree on something or other.  I'm happy to do it
whichever way you decide, but I'd rather not waste my time making
patches that will just get rejected.

-- 
Måns Rullgård
